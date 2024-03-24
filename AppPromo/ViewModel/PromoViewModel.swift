//
//  PromoViewModel.swift
//  AppPromo
//
//  Created by anca dev on 22/03/24.
//

import Foundation

protocol PromoViewModelProtocol: AnyObject {
    var numberOfItem: Int { get }
    var promoOfItem: [Promos] { get }
    
    func loadItem(handle: @escaping(Bool) -> Void)
}

class PromoViewModel: PromoViewModelProtocol {
    
    private var service: ServiceAPIProtocol?
    private var promos: [Promos]?
    
    var numberOfItem: Int {
        guard let promos else {
            return 0
        }
        return promos.count
    }
    
    var promoOfItem: [Promos] {
        guard let promos else {
            return [Promos]()
        }
        return promos
    }
    
    func loadItem(handle: @escaping(Bool) -> Void) {
        service = ServiceAPI.shareInstance
        service?.getDataPromo() { completion in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.promos = completion.promos
                handle(true)
            }
        }
    }
    
}
