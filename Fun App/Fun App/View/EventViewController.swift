//
//  ViewController.swift
//  Fun App
//
//  Created by Victor Zhang on 11/11/18.
//  Copyright © 2018 Victor Zhang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventViewController: UIViewController {
    @IBOutlet weak var eventsTableView: UITableView!
    let disposeBag = DisposeBag()
    
    let viewModel: EventViewModel = EventViewModel(disposeBag: DisposeBag())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        
        self.bindEvents()
        viewModel.loadEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func bindEvents() {
        viewModel.events
            .bind(to: self.eventsTableView.rx.items(cellIdentifier: "EventTableViewCell", cellType: EventTableViewCell.self)) { row, event, cell in
                cell.configerView(event: event)
            }
            .disposed(by: self.disposeBag)
    }
}

