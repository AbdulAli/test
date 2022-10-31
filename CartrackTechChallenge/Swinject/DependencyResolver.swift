//
//  DependencyResolver.swift
//  Turbu
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Swinject
import SwinjectStoryboard

public class DependencyResolver {
    private var registers: [Assembly] = [InjectAppViewModels(), InjectAppServices(), InjectAppRepositories()]
    private let resolver: Resolver

    public init() {
        let assembler = try! Assembler(assemblies: self.registers)
        self.resolver = assembler.resolver
    }

    func resolve<Service>(_ serviceType: Service.Type, name: String? = nil) -> Service? {
        return self.resolver.resolve(serviceType, name: name)
    }
}
