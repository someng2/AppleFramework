//
//  FrameworkListViewController.swift
//  AppleFramework
//
//  Created by 백소망 on 2022/08/31.
//

import UIKit

class FrameworkListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let list: [AppleFramework] = AppleFramework.list
    
    
    // Data, Presentation, Layout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationController?.navigationBar.topItem?.title = "☀️ Apple Frameworks"
        
        // 스토리보드에서 collection view의 Estimate size를 None으로 설정한 것 동일한 효과
        // Automatic으로 하면, 코드로 셀 사이즈를 지정해줬는데도 일부는 시스템이 계산한 걸로 보여줌
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.estimatedItemSize = .zero
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
    }
}


extension FrameworkListViewController:
    UICollectionViewDataSource {
    // 몇개나 보여줄거야
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    // 어떻게 셀에 표현할건지
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCell", for: indexPath) as? FrameworkCell else {
            return UICollectionViewCell()
        }
        let framework = list[indexPath.item]
        cell.configure(framework)
        return cell
    }
}

extension FrameworkListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let interItemSpacing: CGFloat = 10
        let padding: CGFloat = 16
        
        // 3열
        let width = (collectionView.bounds.width - interItemSpacing * 2 - padding * 2) / 3
        // 2열
//        let width = (collectionView.bounds.width - interItemSpacing - padding * 2) / 2
        // 4열
//        let width = (collectionView.bounds.width - interItemSpacing * 3 - padding * 2) / 4
        let height = width * 1.5
        return CGSize(width: width, height: height)
        
        
    }
    
    // 아이템 사이 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // 줄 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// 터치한 것 감지하는 기능!
extension FrameworkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framwork = list[indexPath.item]
        print(">>> selected: \(framwork.name)")
    }
}
