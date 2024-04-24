//
//  SkyCell.swift
//  InsiderSDKTaskFramework
//
//  Created by Uslu, Teyhan on 19.04.2024.
//

import UIKit


class SkyCell: UITableViewCell {
    static let identifier = "SkyCell"
    private let fontSize = 15.0
    
    private lazy var containerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var starImage: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
        
    }()
    
    private lazy var sizeLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: fontSize)
        temp.text = "Size"
        return temp
    }()
    
    private lazy var sizeValue: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: fontSize)
        return temp
    }()
    
    private lazy var sizeStackView: UIStackView = {
        let temp = UIStackView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis  = NSLayoutConstraint.Axis.vertical
        temp.distribution  = UIStackView.Distribution.equalCentering
        temp.alignment = UIStackView.Alignment.center
        temp.spacing   = 0
        temp.addArrangedSubview(sizeLabel)
        temp.addArrangedSubview(sizeValue)
        return temp
    }()
    
    private lazy var colorLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: fontSize)
        temp.text = "Color"
        return temp
    }()
    
    private lazy var colorValue: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: fontSize)
        return temp
    }()
    
    private lazy var colorStackView: UIStackView = {
        let temp = UIStackView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis  = NSLayoutConstraint.Axis.vertical
        temp.distribution  = UIStackView.Distribution.fill
        temp.alignment = UIStackView.Alignment.center
        temp.spacing   = 0
        temp.addArrangedSubview(colorLabel)
        temp.addArrangedSubview(colorValue)
        return temp
    }()
    
    private lazy var brightnessLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: fontSize)
        temp.text = "Brightness"
        return temp
    }()
    
    private lazy var brightnessValue: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: fontSize)
        return temp
    }()
    
    private lazy var brightnessStackView: UIStackView = {
        let temp = UIStackView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis  = NSLayoutConstraint.Axis.vertical
        temp.distribution  = UIStackView.Distribution.equalSpacing
        temp.alignment = UIStackView.Alignment.center
        temp.spacing   = 0
        temp.addArrangedSubview(brightnessLabel)
        temp.addArrangedSubview(brightnessValue)
        return temp
    }()
    
    private lazy var stackView: UIStackView = {
        let temp = UIStackView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis  = NSLayoutConstraint.Axis.horizontal
        temp.distribution  = UIStackView.Distribution.fillEqually
        temp.alignment = UIStackView.Alignment.center
        temp.spacing   = 0
        
//        temp.addArrangedSubview(starImage)
        temp.addArrangedSubview(sizeStackView)
        temp.addArrangedSubview(colorStackView)
        temp.addArrangedSubview(brightnessStackView)
        return temp
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fetchStarImage()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fetchStarImage()
        setupView()
    }
    
    private func fetchStarImage() {
        let url = URL(string: "https://img.etimg.com/thumb/msid-72948091,width-650,imgsize-95069,,resizemode-4,quality-100/star_istock.jpg")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async { [weak self] in
                self?.starImage.image = UIImage(data: data!)
            }
        }
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(starImage)
        containerView.addSubview(stackView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            starImage.widthAnchor.constraint(equalToConstant: 90),
            starImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 1),
            starImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -1),
            starImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: -5),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
    
    func setData(star: Star) {
        sizeValue.text = star.size.rawValue
        colorValue.text = star.color.rawValue
        brightnessValue.text = star.isbright ? "Bright" : "Not so bright"
    }
}
