//
//  TempalateCommand.swift
//  templar
//
//  Created by Vladislav Prusakov on 16/02/2019.
//

import SwiftCLI
import Foundation
import Yams
import Files
import xcodeproj
import Rainbow

class TempalateCommand: CommandGroup {
    let name = "template"
    
    var children: [Routable] = [NewTemplateCommand(), UpdateTemplateCommand()]
    
    let shortDescription: String = "Manage your templates files"
}

class NewTemplateCommand: Command {
    
    let name = "new"
    
    let templateName = Parameter()
    
    private let decoder = YAMLDecoder()
    
    func execute() throws {
        let configFile = try Folder.current.file(named: TemplarInfo.configFileName)
        
        var templar = try decoder.decode(Templar.self, from: configFile.readAsString())
        
        let templatesFolder = try Folder.current.subfolder(named: templar.templateFolder)
        
        let rootModulePath = Input.readLineWhileNotGetAnswer(prompt: "Enter path to root module:",
                                                             error: "Root path can't be empty",
                                                             output: stderr)
        
        let template = Template(
            version: "1.0.0",
            summary: "ENTER_YOUR_SUMMORY",
            author: "ENTER_YOUR",
            root: rootModulePath,
            files: [Template.File(name: "View/ViewController.swift", path: "View/ViewController.swift.templar")],
            replaceRules: [Template.Rule(pattern: "__NAME__", question: "Name of your module:")]
        )
        
        let templateData = try YAMLEncoder().encode(template)
        
        let templateFolder = try templatesFolder.createSubfolder(named: templateName.value)
        try templateFolder.createFile(named: Template.makeFullName(from: templateName.value),
                                      contents: templateData)
        
        switch templar.kind {
        case .xcodeproj(var project):
            project.templates.insert(templateName.value)
            templar.kind = .xcodeproj(project)
        case .custom(var custom):
            custom.templates.insert(templateName.value)
            templar.kind = .custom(custom)
        }
        
        let newTemplar = try YAMLEncoder().encode(templar)
        try Folder.current.createFile(named: TemplarInfo.configFileName, contents: newTemplar)
    }
}

extension Input {
    static func readLineWhileNotGetAnswer(prompt: String, error: String, output: WritableStream) -> String {
        let answer = Input.readLine(prompt: prompt.green)
        
        guard !answer.isEmpty else {
            output <<< error.red
            return readLineWhileNotGetAnswer(prompt: prompt, error: error, output: output)
        }
        
        return answer
    }
}

class UpdateTemplateCommand: Command {
    
    let name = "update"
    
    let updateRepoFlag = Flag("-r", "--repo", description: "Update templar repo folder", defaultValue: false)
    let updateFilesFlag = Key<String>("--files", description: "Scan and update files to template")
    
    func execute() throws {
//        if let key = updateFilesFlag.value {
//
//        }
    }
}