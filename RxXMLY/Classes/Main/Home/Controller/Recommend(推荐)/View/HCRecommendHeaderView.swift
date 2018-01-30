//
//  HCRecommendHeaderView.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/17.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReusableKit
import NSObject_Rx

fileprivate struct Metric {
    
    static let defaultHeight : CGFloat = 90.0
    static let minHeight : CGFloat = 45.0
}

class HCRecommendHeaderView: UICollectionReusableView, NibLoadable {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!

    @IBOutlet weak var leftTitle: UILabel!
    @IBOutlet weak var leftSubView: UIView!
    @IBOutlet weak var leftSubTitle: UILabel!
    
    @IBOutlet weak var rightSubView: UIView!
    @IBOutlet weak var rightSubTitle: UILabel!
    
    @IBOutlet weak var tagView1: UIView!
    @IBOutlet weak var tagView2: UIView!
    @IBOutlet weak var tagView3: UIView!
    @IBOutlet weak var tagView4: UIView!

    @IBOutlet weak var tagLab1: UILabel!
    @IBOutlet weak var tagLab2: UILabel!
    @IBOutlet weak var tagLab3: UILabel!
    @IBOutlet weak var tagLab4: UILabel!
    
    var categoryModel: Variable<HCCategoryModel?> = Variable(nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        bindUI()
    }
    
    private func bindUI() {
        
        categoryModel.asObservable().subscribe(onNext: { model in
            
            if let beel = model?.showInterestCard {
                self.leftSubView.isHidden = !beel
            }

            self.leftTitle.text = model?.title
            
            guard let keywords = model?.keywords, keywords.count > 0 else {
                
                self.height = Metric.minHeight
                self.bottomView.isHidden = true
                return
            }
            
            self.height = Metric.defaultHeight
            self.bottomView.isHidden = false

            self.tagLab1.text = model?.keywords![0].keywordName
            self.tagLab2.text = model?.keywords![1].keywordName
            self.tagLab3.text = model?.keywords![2].keywordName
            self.tagLab4.text = model?.keywords![3].keywordName

        }).disposed(by: rx.disposeBag)
    }
    
    private func initUI() {
        
        tagView1.backgroundColor = .clear
        tagView1.layer.cornerRadius = tagView1.height / 2
        tagView1.layer.masksToBounds = true
        tagView1.layer.borderColor = UIColor.darkGray.cgColor
        tagView1.layer.borderWidth = 0.6
        
        tagView2.backgroundColor = .clear
        tagView2.layer.cornerRadius = tagView2.height / 2
        tagView2.layer.masksToBounds = true
        tagView2.layer.borderColor = UIColor.darkGray.cgColor
        tagView2.layer.borderWidth = 0.6
        
        tagView3.backgroundColor = .clear
        tagView3.layer.cornerRadius = tagView3.height / 2
        tagView3.layer.masksToBounds = true
        tagView3.layer.borderColor = UIColor.darkGray.cgColor
        tagView3.layer.borderWidth = 0.6
        
        tagView4.backgroundColor = .clear
        tagView4.layer.cornerRadius = tagView4.height / 2
        tagView4.layer.masksToBounds = true
        tagView4.layer.borderColor = UIColor.darkGray.cgColor
        tagView4.layer.borderWidth = 0.6
    }
    
    static func defaultHeaderSize() -> CGSize {
        
        return CGSize(width: kScreenW, height: Metric.defaultHeight)
    }
    
    static func minHeaderSize() -> CGSize {
        
        return CGSize(width: kScreenW, height: Metric.minHeight)
    }
}
