//
//  ViewController.swift
//  AppPromo
//
//  Created by anca dev on 22/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listPromo: UITableView!
    
    private var viewModel: PromoViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        title = "Promo"
        
        viewModel = PromoViewModel()
        viewModel?.loadItem() { handle in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if handle {
                    self.listPromo.reloadData()
                }
            }
        }
        
        listPromoSetup()
    }
    
    private func listPromoSetup() {
        listPromo.register(UINib(nibName: PromoCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: PromoCell.cellIdentifier)
    }
    
    private func openDetailPromo(urlStr: String) {
        guard let vc = DetailPromoViewController.getViewController() as? DetailPromoViewController else {
            return
        }
        vc.urlStr = urlStr
        
        self.navigationController?.pushViewController(vc,
                                                      animated: true)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel else {
            return 0
        }
        return viewModel.numberOfItem
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoCell.cellIdentifier,
                                                       for: indexPath) as? PromoCell,
              let viewModel else {
            return UITableViewCell()
        }
        
        if !cell.alreadySetup {
            let namaPromo = viewModel.promoOfItem[indexPath.row].name
            cell.initialSetup(namaPromo: namaPromo)
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel else {
            return
        }
        
        let urlStr = viewModel.promoOfItem[indexPath.row].detail
        openDetailPromo(urlStr: urlStr)
    }
    
}
