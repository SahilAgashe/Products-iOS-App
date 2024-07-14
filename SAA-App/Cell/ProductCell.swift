//
//  ProductCell.swift
//  SAA-App
//
//  Created by SAHIL AMRUT AGASHE on 13/07/24.
//

import UIKit
import SwiftUI

class ProductCell: UITableViewCell {
    
    // MARK: - Properties
    lazy var imgView: LazyImageView = {
        let iv = LazyImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "loader_image")
        return iv
    }()
    
    lazy var lbl1: UILabel = {
        let lbl = UILabel()
        lbl.text = "Hello"
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var lbl2: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sahil"
        lbl.textAlignment = .center
        return lbl
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupUI() {
        let vstack = UIStackView(arrangedSubviews: [lbl1, lbl2])
        vstack.spacing = 20
        vstack.axis = .vertical
        
        let hstack = UIStackView(arrangedSubviews:[imgView, vstack])
        hstack.translatesAutoresizingMaskIntoConstraints = false
        hstack.axis = .horizontal
        hstack.spacing = 20
        hstack.distribution = .fillEqually
        hstack.alignment = .center
        contentView.addSubview(hstack)
        
        NSLayoutConstraint.activate([
            hstack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hstack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            hstack.widthAnchor.constraint(equalTo: contentView.widthAnchor , multiplier: 0.8),
            hstack.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8)
        ])
        
        selectionStyle = .none
    }
}

struct ProductCellScreen: UIViewRepresentable {
    func updateUIView(_ uiView: ProductCell, context: Context) {}
    
    func makeUIView(context: Context) -> ProductCell {
        ProductCell()
    }
}

struct ProductCellScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellScreen()
    }
}
