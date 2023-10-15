//
//  ViewController.swift
//  AppleShopping
//
//  Created by teona nemsadze on 02.10.23.
//

import UIKit

struct TextCellViewModel {
    let text: String
    let font: UIFont
}

enum SectionType {
    case productPhotos(images: [UIImage])
    case productInfo(viewModels: [TextCellViewModel])
    case relatedProducts(viewModels: [RelatedProductTableViewCellViewModel])
    
    var title: String? {
        switch self {
        case .relatedProducts:
        return "Reload Products"
    default:
        return nil
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(PhotoCarouselTableViewCell.self,
                       forCellReuseIdentifier: PhotoCarouselTableViewCell.identifier)
        table.register(RelatedProductTableViewCell.self,
                       forCellReuseIdentifier: RelatedProductTableViewCell.identifier)
        
        return table
    }()
    
    private var sections = [SectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSections()
        title = "Apple devices"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func configureSections() {
        sections.append(.productPhotos(images: [
         UIImage(named: "photo1"),
         UIImage(named: "photo2"),
         UIImage(named: "photo3"),
         UIImage(named: "photo4")
        ].compactMap({ $0 })))
        sections.append(.productInfo(viewModels: [
            TextCellViewModel(text: "This timeline of Apple products is a list of all computers, phones, tablets, wearables, and other products sold by Apple Inc. This list is ordered by the release date of the products. Macintosh Performa models were often physically identical to other models, in which case they are omitted in favor of the identical twin.",
                font: .systemFont(ofSize: 18)
              ),
            TextCellViewModel(
                text: "Price: $160",
                font: .systemFont(ofSize: 22)
                )
        ]))
        //chasasworebelia eseni...
        sections.append(.relatedProducts(viewModels: [
            RelatedProductTableViewCellViewModel(image: UIImage(named: "photo1"),
            title: "iPhone is a line of smartphones produced by Apple Inc. that use Apple's own iOS mobile operating system. The first-generation iPhone was announced by then-Apple CEO Steve Jobs on January 9, 2007."),
            RelatedProductTableViewCellViewModel(image: UIImage(named: "photo2"),
            title: "AirPods are wireless Bluetooth earbuds designed by Apple Inc. They were first announced on September 7, 2016, alongside the iPhone 7. Within two years, they became Apple's most popular accessory. AirPods are Apple's entry-level wireless headphones, sold alongside the AirPods Pro and AirPods Max."),
            RelatedProductTableViewCellViewModel(image: UIImage(named: "photo3"),
            title: "The MacBook Pro is a line of Mac laptops made by Apple Inc. Introduced in January 2006, it is the higher-end lineup in the MacBook family, sitting above the consumer-focused MacBook Air. It is currently sold with 13-inch, 14-inch, and 16-inch screens, all using Apple silicon M-series chips."),
            RelatedProductTableViewCellViewModel(image: UIImage(named: "photo4"),
            title: "The Apple Watch is a line of smartwatches produced by Apple Inc. It incorporates fitness tracking, health-oriented capabilities, and wireless telecommunication, and integrates with iOS and other Apple products and services. The Apple Watch was released in April 2015, and quickly became the best-selling wearable device: 4.2 million were sold in the second quarter of fiscal 2015, and more than 115 million people were estimated to use an Apple Watch as of December 2022.")
           
        ]))
    } 
    //Table
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .productPhotos:
        return 1
            
        case .productInfo(let viewModels):
            return viewModels.count
            
        case .relatedProducts(let viewModels):
            return viewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        return sectionType.title
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .productPhotos(let images):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotoCarouselTableViewCell.identifier,
            for: indexPath
        ) as? PhotoCarouselTableViewCell else {
            fatalError()
        }
            
            cell.configure(with: images)
        return cell
        
    case .productInfo(let viewModels):
            let viewModel = viewModels[indexPath.row]
           let cell = tableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath
        )
            cell.configure(with: viewModel)
        return cell
        case .relatedProducts(let viewModels):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RelatedProductTableViewCell.identifier, for: indexPath) as?
                    RelatedProductTableViewCell else {
                fatalError()
            }
            
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .productPhotos:
            return view.frame.size.width
        case .relatedProducts:
            return 150
        case .productInfo:
            return UITableView.automaticDimension
        }
    }
}

extension UITableViewCell {
    func configure(with viewModel: TextCellViewModel) {
        textLabel?.text = viewModel.text
        textLabel?.numberOfLines = 0
        textLabel?.font = viewModel.font
    }
}
 






