//
//  MonsterListRouter.swift
//  UhooiPicBook
//
//  Created by uhooi on 28/02/2020.
//  Copyright © 2020 THE Uhooi. All rights reserved.
//

import UIKit

/// @mockable
protocol MonsterListRouterInput: AnyObject {
    func showMonsterDetail(monster: MonsterEntity)
}

final class MonsterListRouter {

    // MARK: Stored Instance Properties

    private unowned let viewController: MonsterListViewController

    // MARK: Initializers

    private init(viewController: MonsterListViewController) {
        self.viewController = viewController
    }

    // MARK: Type Methods

    static func assembleModule() -> MonsterListViewController {
        guard let view = R.storyboard.monsterList.instantiateInitialViewController() else {
            fatalError("Fail to load MonsterListViewController from Storyboard.")
        }
        let interactor = MonsterListInteractor(monstersRepository: MonstersFirebaseClient())
        let router = MonsterListRouter(viewController: view)
        let presenter = MonsterListPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        view.imageCacheManager = ImageCacheManager()
        interactor.presenter = presenter

        return view
    }

    // MARK: Other Private Methods

}

extension MonsterListRouter: MonsterListRouterInput {

    func showMonsterDetail(monster: MonsterEntity) {
        let vc = MonsterDetailRouter.assembleModule(monster: monster)
        self.viewController.present(vc, animated: true)
    }

}