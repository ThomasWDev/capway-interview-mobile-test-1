//
//  CWMultipleImageCell.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class CWMultipleImageCell: UITableViewCell {
    
    static let identifier = "CWMultipleImageCell"
    static let MAX_IMAGES_TO_DISPLAY = 3

    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var dateLbl: UILabel!
    @IBOutlet weak private var moreBtn: UIButton!
    @IBOutlet weak private var detailsLbl: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var collectionViewLayout: RAMCollectionViewFlemishBondLayoutSwift!
    @IBOutlet weak private var likeLbl: UILabel!
    @IBOutlet weak private var commentLbl: UILabel!
    @IBOutlet weak private var shareBtn: UIButton!
    @IBOutlet weak private var heartBtn: UIButton!
    @IBOutlet weak private var commentBtn: UIButton!
    
    private var dataList: DashboardResponse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(data: DashboardResponse){
        dataList = data
        let post = data.postTitle ?? Post()
        titleLbl.attributedText = Helper.postAttributedTxt(post: post)
        dateLbl.text = data.postDate
        moreBtn.isHidden = (data.isMoreBtnHide ?? false)
        detailsLbl.text = data.details
        likeLbl.text = "\(data.likeCount ?? 0)"
        commentLbl.text = "\(data.commentCount ?? 0)"
        collectionView.reloadData()
    }

    @IBAction func moreBtnAction(_ sender: Any) {
    }
    
    @IBAction func shareBtnAction(_ sender: Any) {
    }
    
    @IBAction func heartBtnAction(_ sender: Any) {
    }
    
    @IBAction func commentBtnAction(_ sender: Any) {
    }
    
    private func setupCollectionView(){
        self.collectionViewLayout.delegate = self
        self.collectionViewLayout.numberOfElements = CWMultipleImageCell.MAX_IMAGES_TO_DISPLAY
        self.collectionViewLayout.highlightedCellHeight = UIScreen.main.bounds.size.width * 2/CGFloat(CWMultipleImageCell.MAX_IMAGES_TO_DISPLAY)
        self.collectionViewLayout.highlightedCellWidth = UIScreen.main.bounds.size.width*2/CGFloat(CWMultipleImageCell.MAX_IMAGES_TO_DISPLAY)
    }
}

extension CWMultipleImageCell : RAMCollectionViewFlemishBondLayoutDelegate {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: RAMCollectionViewFlemishBondLayoutSwift, estimatedSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize.zero
        }

        func collectionView(collectionView: UICollectionView, layout collectionViewLayout: RAMCollectionViewFlemishBondLayoutSwift, estimatedSizeForFooterInSection section: Int) -> CGSize {
            return CGSize.zero
        }

        func collectionView(collectionView: UICollectionView, layout collectionViewLayout: RAMCollectionViewFlemishBondLayoutSwift, highlightedCellDirectionForGroup group: Int, atIndexPath indexPath: NSIndexPath) -> RAMCollectionViewFlemishBondLayoutGroupDirection {
            var direction: RAMCollectionViewFlemishBondLayoutGroupDirection
            if indexPath.row % 2 != 0 {
                direction = .Right
            } else {
                direction = .Left
            }
            return direction
        }
}

extension CWMultipleImageCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataList?.multipleImage?.count == 0{
            Helper.emptyMessageInCollectionView(collectionView, "No data available")
        } else {
            collectionView.backgroundView = nil
        }
        if let count = dataList?.multipleImage?.count {
            return count > CWMultipleImageCell.MAX_IMAGES_TO_DISPLAY ? CWMultipleImageCell.MAX_IMAGES_TO_DISPLAY : count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CWImageCell.identifier, for: indexPath) as! CWImageCell
        let imageName = dataList?.multipleImage?[indexPath.row] ?? ""
        let count = dataList!.multipleImage!.count
        let counterDisplay = count > CWMultipleImageCell.MAX_IMAGES_TO_DISPLAY ? CWMultipleImageCell.MAX_IMAGES_TO_DISPLAY : count
        cell.configureCell(imageName: imageName, imageCounter: count, isLastCell: indexPath.row == counterDisplay - 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageName = dataList?.multipleImage?[indexPath.row] ?? ""
        
        showImageDetails(imageName: imageName)
    }
    
    private func showImageDetails(imageName: String){
        let storyboard = UIStoryboard(storyboard: .dashboard)
        let vc = storyboard.instantiateViewController(withIdentifier: CWImageDetailsVC.self)
        vc.imageName = imageName
        let mwindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        guard let parentVC = mwindow?.visibleViewController() else {return}
        parentVC.present(vc, animated: true, completion: nil)
    }
}

enum RAMCollectionViewFlemishBondLayoutGroupDirection {
    case Left, Right
}

class RAMCollectionViewFlemishBondLayoutAttributesSwift: UICollectionViewLayoutAttributes {

    var highlightedCell: Bool = false
    var highlightedCellDirection : RAMCollectionViewFlemishBondLayoutGroupDirection = .Left

    override func copy(with zone: NSZone? = nil) -> Any {
        let attributes: RAMCollectionViewFlemishBondLayoutAttributesSwift = super.copy(with: zone) as! RAMCollectionViewFlemishBondLayoutAttributesSwift
        attributes.highlightedCell = self.highlightedCell
        attributes.highlightedCellDirection = self.highlightedCellDirection
        return attributes
    }

    override var debugDescription: String {
        let highlightedCellString = "Highlighted cell: \(self.highlightedCell == true ? "Yes" : "No"); "
        let highlightedCellDirectionString = "Highlighted cell direction: \((self.highlightedCellDirection == .Left) ? "Left" : "Right"); "
        return self.description.appendingFormat("%@%@", highlightedCellString, highlightedCellDirectionString)
    }
}

protocol RAMCollectionViewFlemishBondLayoutDelegate: NSObjectProtocol {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: RAMCollectionViewFlemishBondLayoutSwift, highlightedCellDirectionForGroup group: Int, atIndexPath indexPath: NSIndexPath) -> RAMCollectionViewFlemishBondLayoutGroupDirection

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: RAMCollectionViewFlemishBondLayoutSwift, estimatedSizeForHeaderInSection section: Int) -> CGSize

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: RAMCollectionViewFlemishBondLayoutSwift, estimatedSizeForFooterInSection section: Int) -> CGSize
}



let RAMCollectionViewFlemishBondCellKind = "RAMCollectionViewFlemishBondCellKind"
let RAMCollectionViewFlemishBondHeaderKind = "RAMCollectionViewFlemishBondHeaderKind"
let RAMCollectionViewFlemishBondFooterKind = "RAMCollectionViewFlemishBondFooterKind"

class RAMCollectionViewFlemishBondLayoutSwift: UICollectionViewLayout {

    weak var delegate: RAMCollectionViewFlemishBondLayoutDelegate?
    var numberOfElements: Int = 0
    // Number to be grouped cells. Default: 3
    var highlightedCellWidth: CGFloat = 0.0
    // Width of highlighted cell. Default: self.collectionView.bounds.size.width / 2
    var highlightedCellHeight: CGFloat = 0.0

    var cellSpacing: CGFloat = CGFloat(8)

    // MARK: - Private Variables

    var layoutInfo : [String: [NSIndexPath: UICollectionViewLayoutAttributes]] = [:]

    var headerSizes : [NSIndexPath: CGSize] = [:]
    var footerSizes : [NSIndexPath: CGSize] = [:]

    var highlightedCellDirection: RAMCollectionViewFlemishBondLayoutGroupDirection = .Left


    // MARK: - Lifecycle

    override init() {
        super.init()

        self.setup()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()

    }

    // MARK: - Custom Getter

    var cellWidth: CGFloat {
        return self.collectionView!.bounds.size.width - self.highlightedCellWidth - 2*self.cellSpacing
    }


    var cellHeight: CGFloat {
        return self.highlightedCellHeight / (CGFloat(self.numberOfElements) - 1) - self.cellSpacing/2.0
    }

    var numberOfSections: Int {
        return self.collectionView!.numberOfSections
    }

    var totalGroupsInCollectionView: Int {
        var totalGroups = 0
        for section in 0..<self.numberOfSections {
            let indexPath = NSIndexPath(item: 0, section: section)
            totalGroups += self.totalGroupsAtIndexPath(indexPath: indexPath)
        }
        return totalGroups
    }

    var totalHeaderHeight: CGFloat {
        var totalHeight: CGFloat = 0.0
        for (_, size) in self.headerSizes {
            totalHeight += size.height
        }
        return totalHeight
    }

    var totalFooterHeight: CGFloat {
        var totalHeight: CGFloat = 0.0
        for (_, size) in self.footerSizes {
            totalHeight += size.height
        }
        return totalHeight
    }

    // MARK: - Setup

    func setup() {
        // Default values
        self.numberOfElements = 3
        self.highlightedCellHeight = 200.0
        self.highlightedCellWidth = 0.0
    }
    // MARK: - UICollectionViewLayout


//    override class func layoutAttributesClass() -> AnyClass {
//        return RAMCollectionViewFlemishBondLayoutAttributesSwift.self
//    }

    override func prepare() {

        var newLayoutDictionary = [String : [NSIndexPath:UICollectionViewLayoutAttributes]]()
        var cellLayoutDictionary = [NSIndexPath : UICollectionViewLayoutAttributes]()
        var headerLayoutDictionary = [NSIndexPath : UICollectionViewLayoutAttributes]()
        var footerLayoutDictionary = [NSIndexPath : UICollectionViewLayoutAttributes]()
        self.checkHighlightedCellWidth()
        for section in 0..<self.numberOfSections {
            let itemsCount = self.collectionView!.numberOfItems(inSection: section)
            for item in 0..<itemsCount {
                let indexPath = NSIndexPath(item: item, section: section)
                if indexPath.item == 0 {
                    let size = self.estimatedSizeForHeaderInSection(section: section)
                    if !size.equalTo(CGSize.zero) {
                        self.headerSizes[indexPath] = size
                        let headerAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind:RAMCollectionViewFlemishBondHeaderKind, with: indexPath as IndexPath)
                        headerAttributes.frame = self.frameForHeaderAtIndexPath(indexPath: indexPath, withSize: size)
                        headerLayoutDictionary[indexPath] = headerAttributes
                    }
                }
                else if self.isTheLastItemAtIndexPath(indexPath: indexPath) {
                    let size = self.estimatedSizeForFooterInSection(section: section)
                    if !size.equalTo(CGSize.zero) {
                        self.footerSizes[indexPath] = size
                        let footerAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind:RAMCollectionViewFlemishBondFooterKind, with: indexPath as IndexPath)
                        footerAttributes.frame = self.frameForFooterAtIndexPath(indexPath: indexPath, withSize: size)
                        footerLayoutDictionary[indexPath] = footerAttributes
                    }
                }

                let layoutAttributes = RAMCollectionViewFlemishBondLayoutAttributesSwift(forCellWith:indexPath as IndexPath)
                layoutAttributes.frame = self.frameForCellAtIndexPath(indexPath: indexPath)
                layoutAttributes.highlightedCell = self.isHighLightedElementAtIndexPath(indexPath: indexPath)
                layoutAttributes.highlightedCellDirection = self.highlightedCellDirection
                cellLayoutDictionary[indexPath] = layoutAttributes
            }

            let mod = itemsCount % self.numberOfElements
            if mod == 1 {
                let indexPath = NSIndexPath(item: itemsCount - 1, section: section)
                let layoutAttributes = cellLayoutDictionary[indexPath]
                if var frame = layoutAttributes?.frame {
                    frame.origin.x = 0.0
                    frame.size = CGSize(width: UIScreen.main.bounds.width + 1.0, height:  400.0)
                    layoutAttributes?.frame = frame
                }
            } else if mod == 2 {
                let indexPath1 = NSIndexPath(item: itemsCount - 2, section: section)
                let layoutAttributes_1 = cellLayoutDictionary[indexPath1] as! RAMCollectionViewFlemishBondLayoutAttributesSwift

                var frame1 = layoutAttributes_1.frame
                if layoutAttributes_1.highlightedCellDirection == .Right {
                    frame1.origin.x = UIScreen.main.bounds.width/2
                    frame1.size = CGSize(width: UIScreen.main.bounds.width/2 + 1.0, height:  200)
                } else {
                    frame1.size = CGSize(width: UIScreen.main.bounds.width/2, height:  200)
                }

                layoutAttributes_1.frame = frame1

                let indexPath2 = NSIndexPath(item: itemsCount - 1, section: section)
                let layoutAttributes_2 = cellLayoutDictionary[indexPath2] as! RAMCollectionViewFlemishBondLayoutAttributesSwift

                var frame2 = layoutAttributes_2.frame
                if layoutAttributes_2.highlightedCellDirection == .Left {
                    frame2.origin.x = UIScreen.main.bounds.width/2
                    frame2.size = CGSize(width: UIScreen.main.bounds.width/2 + 1.0, height:  200)
                } else {
                    frame2.size = CGSize(width: UIScreen.main.bounds.width/2, height:  200)
                }

                layoutAttributes_2.frame = frame2
            }
        }
        newLayoutDictionary[RAMCollectionViewFlemishBondCellKind] = cellLayoutDictionary
        newLayoutDictionary[RAMCollectionViewFlemishBondHeaderKind] = headerLayoutDictionary
        newLayoutDictionary[RAMCollectionViewFlemishBondFooterKind] = footerLayoutDictionary
        self.layoutInfo = newLayoutDictionary
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes] {
        var allAttributes = [UICollectionViewLayoutAttributes]() /* capacity: self.layoutInfo.count */

        for (_, elementsInfo) in self.layoutInfo {
            for (_, attributes) in elementsInfo {
                if rect.intersects(attributes.frame) {
                    allAttributes.append(attributes)
                }
            }
        }
        return allAttributes
    }

//    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes {
//        return self.layoutInfo[RAMCollectionViewFlemishBondCellKind]![indexPath]!
//    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.layoutInfo[RAMCollectionViewFlemishBondCellKind]![indexPath as NSIndexPath]
    }

//    override func layoutAttributesForSupplementaryViewOfKind(kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes {
//        return self.layoutInfo[kind]![indexPath]!
//    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
         return self.layoutInfo[elementKind]![indexPath as NSIndexPath]!
    }


//    override func collectionViewContentSize() -> CGSize {
//        if self.itemCountAtSection(section: 0) == 0 {
//            return CGSize.zero
//        }
//        return CGSize.init(width: self.collectionView!.bounds.size.width, height: (self.highlightedCellHeight * CGFloat(self.totalGroupsInCollectionView)) + self.totalHeaderHeight + self.totalFooterHeight)
//    }

    override var collectionViewContentSize: CGSize {
        get {
            let itemCounts = self.itemCountAtSection(section: 0)
            if itemCounts == 0 {
                return CGSize.zero
            }
            let firstNGroups = CGFloat(self.totalGroupsInCollectionView - 1)
            if itemCounts % self.numberOfElements == 1 {
                return CGSize.init(width: self.collectionView!.bounds.size.width, height: (self.highlightedCellHeight * firstNGroups) + (firstNGroups * cellSpacing) + UIScreen.main.bounds.width + self.totalHeaderHeight + self.totalFooterHeight)
            }

            if itemCounts % self.numberOfElements == 2 {
                return CGSize.init(width: self.collectionView!.bounds.size.width, height: (self.highlightedCellHeight * firstNGroups) + (firstNGroups * cellSpacing) + UIScreen.main.bounds.width/2 + self.totalHeaderHeight + self.totalFooterHeight)
            }

            return CGSize.init(width: self.collectionView!.bounds.size.width, height: (self.highlightedCellHeight * CGFloat(self.totalGroupsInCollectionView)) + (firstNGroups * cellSpacing) + self.totalHeaderHeight + self.totalFooterHeight)
        }
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    // MARK: - Private Methods

    func frameForCellAtIndexPath(indexPath: NSIndexPath) -> CGRect {
        var frame = CGRect.zero
        if self.isHighLightedElementAtIndexPath(indexPath: indexPath) {
            self.highlightedCellDirection = self.delegate?.collectionView(collectionView: self.collectionView!, layout: self, highlightedCellDirectionForGroup: self.currentGroupAtIndexPath(indexPath: indexPath), atIndexPath: indexPath) ?? .Left
            var coordinateX: CGFloat = self.highlightedCellDirection == .Left ? 0 : self.cellWidth
            coordinateX = coordinateX == 0 ? self.cellSpacing/2.0 : coordinateX + 1.5*self.cellSpacing

            let coordinateY: CGFloat = self.getYAtIndexPath(indexPath: indexPath)

            frame = CGRect.init(x: coordinateX, y: coordinateY, width: self.highlightedCellWidth, height: self.highlightedCellHeight)
        } else {
            var coordinateX: CGFloat = self.highlightedCellDirection == .Left ? self.highlightedCellWidth : 0
            coordinateX = coordinateX == 0 ? self.cellSpacing/2.0 : coordinateX + 1.5*self.cellSpacing

            let coordinateY: CGFloat = self.getYAtIndexPath(indexPath: indexPath)

            frame = CGRect.init(x: coordinateX , y: coordinateY, width: self.cellWidth, height: self.cellHeight)
        }
        return frame
    }

    func frameForHeaderAtIndexPath(indexPath: NSIndexPath, withSize size: CGSize) -> CGRect {
        var frame = CGRect.zero
        if indexPath.section == 0 {
            frame.origin.y = 0
        }
        else {
            frame.origin.y = self.getYAtIndexPath(indexPath: indexPath) - size.height
        }
        frame.size = size
        return frame
    }

    func frameForFooterAtIndexPath(indexPath: NSIndexPath, withSize size: CGSize) -> CGRect {
        var frame = CGRect.zero
        frame.origin.y = self.getYAtIndexPath(indexPath: indexPath) + self.highlightedCellHeight
        frame.size = size
        return frame
    }

    func getYAtIndexPath(indexPath: NSIndexPath) -> CGFloat {

        let currentGroup = self.currentGroupAtIndexPath(indexPath: indexPath)
        var yValue: CGFloat = 0.0
        let indexPathFirstElementCurrentSection = NSIndexPath(row: 0, section: indexPath.section)
        if self.isHighLightedElementAtIndexPath(indexPath: indexPath) {
            yValue = (CGFloat(currentGroup) - 1) * self.highlightedCellHeight + self.heightHeaderAtIndexPath(indexPath: indexPathFirstElementCurrentSection)
            yValue += (CGFloat(currentGroup) - 1) * self.cellSpacing + self.cellSpacing/2.0
        } else {
            var position: Int
            if indexPath.row <= self.numberOfElements {
                position = (indexPath.row - 1)
            }
            else {
                let maxElement = self.numberOfElements * currentGroup
                position = (indexPath.row - 1) - (maxElement - self.numberOfElements)
            }
            yValue = ((CGFloat(currentGroup) - 1) * self.highlightedCellHeight) + (self.cellHeight * CGFloat(position)) + self.heightHeaderAtIndexPath(indexPath: indexPathFirstElementCurrentSection)
            yValue += (CGFloat(currentGroup) - 1) * self.cellSpacing + self.cellSpacing/2.0
            yValue += position == 1 ? self.cellSpacing : 0
        }
        if indexPath.section > 0 {
            yValue += (self.highlightedCellHeight * CGFloat(indexPath.section) * CGFloat(self.totalGroupsAtIndexPath(indexPath: indexPath))) + self.headerAndFooterHeightsPreviouslyAtIndexPath(indexPath: indexPath)
        }

        return yValue
    }

    func headerAndFooterHeightsPreviouslyAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        var totalHeight: CGFloat = 0.0
        for section in 0..<indexPath.section {
            let sizeHeader = self.estimatedSizeForHeaderInSection(section: section)
            let sizeFooter = self.estimatedSizeForFooterInSection(section: section)
            totalHeight += sizeHeader.height + sizeFooter.height
        }
        return totalHeight
    }

    func estimatedSizeForHeaderInSection(section: Int) -> CGSize {
        let size = self.delegate?.collectionView(collectionView: self.collectionView!, layout: self, estimatedSizeForHeaderInSection: section) ?? CGSize.zero
        return size
    }

    func estimatedSizeForFooterInSection(section: Int) -> CGSize {
        let size = self.delegate?.collectionView(collectionView: self.collectionView!, layout: self, estimatedSizeForHeaderInSection: section) ?? CGSize.zero
        return size
    }

    func isHighLightedElementAtIndexPath(indexPath: NSIndexPath) -> Bool {
        if (indexPath.row % self.numberOfElements) == 0 {
            return true
        }
        return false
    }

    func currentGroupAtIndexPath(indexPath: NSIndexPath) -> Int {
        let item = indexPath.row + 1
        var resultValue = item / self.numberOfElements
        let mod = item % self.numberOfElements
        if mod > 0 {
            resultValue += 1
        }
        return resultValue
    }

    func totalGroupsAtIndexPath(indexPath: NSIndexPath) -> Int {
        let itemsCount = self.collectionView!.numberOfItems(inSection: indexPath.section)
        if itemsCount <= self.numberOfElements {
            return 1
        }
        var resultValue = itemsCount / self.numberOfElements
        let mod = itemsCount % self.numberOfElements
        if mod > 0 {
            resultValue += 1
        }
        return resultValue
    }

    func heightHeaderAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        guard let size = self.headerSizes[indexPath] else { return 0 }
        return size.height
    }


    func itemCountAtSection(section: Int) -> Int {
        if self.numberOfSections == 0 {
            return 0
        }
        return self.collectionView!.numberOfItems(inSection: section)
    }

    func isTheLastItemAtIndexPath(indexPath: NSIndexPath) -> Bool {
        if (indexPath.row + 1) == self.itemCountAtSection(section: indexPath.section) {
            return true
        }
        return false
    }

    func checkHighlightedCellWidth() {
        if self.highlightedCellWidth == 0 {
            self.highlightedCellWidth = self.collectionView!.bounds.size.width / 2
        }
    }
}
