//
//  VehicleDetailsViewController.swift
//  koolicar
//
//  Created by Werck Ayrton on 04/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift
import MapKit

class VehicleDetailsViewController: UIViewController {

    let disposeBag: DisposeBag = DisposeBag()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewContainerView: UIView!
    @IBOutlet weak var categoryBackgroundView: UIView!

    @IBOutlet weak var imageViewTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var placesLabel: UILabel!
    @IBOutlet weak var fuelLabel: UILabel!
    @IBOutlet weak var doorsLabel: UILabel!
    @IBOutlet weak var gearsTypeLabel: UILabel!

    @IBOutlet weak var mapView: MKMapView!

    var presenter: VehicleDetailsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindPresenter()
    }

    func configureUI() {
        navigationItem.largeTitleDisplayMode = .never
        self.isHeroEnabled = true
        brandLabel.heroID = "Brand+\(presenter.vehicleId)"
        categoryLabel.heroID = "Category+\(presenter.vehicleId)"
        imageView.heroID = "Image+\(presenter.vehicleId)"
        view.backgroundColor = Theme.Color.backgroundColor.color

        mapView.delegate = self
        mapView.isUserInteractionEnabled = false

        Theme.set(themeFont: .title, for: [brandLabel])
        Theme.set(themeFont: .body, for: [yearLabel, placesLabel, fuelLabel, doorsLabel, gearsTypeLabel])
        Theme.set(themeFont: .subTitle, for: [categoryLabel])
        Theme.set(textThemeColor: .darkPrimaryColor,
                  for: [brandLabel, yearLabel, placesLabel, fuelLabel, doorsLabel, gearsTypeLabel])
        Theme.set(textThemeColor: .disabledColor, for: [categoryLabel])

        categoryBackgroundView.backgroundColor = Theme.Color.backgroundColor.color
        categoryBackgroundView.layer.cornerRadius = 9.0
        categoryBackgroundView.clipsToBounds = true

        scrollView.delegate = self
    }

    func bindPresenter() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = VehicleDetailsPresenter.Input(trigger: viewWillAppear)
        let output = presenter.transform(input: input)

        output.vehicleDetailItem.drive(onNext: { [unowned self] (item) in
            self.brandLabel.text = item.brand
            self.categoryLabel.text = item.category
            self.doorsLabel.text = item.doors
            self.fuelLabel.text = item.fuel
            self.gearsTypeLabel.text = item.gears
            self.yearLabel.text = item.year
            self.placesLabel.text = item.places
            self.imageView.sd_setImage(with: item.vehicleImage, completed: nil)
            self.drawCircle(centerCoordinate: item.coordinate)
            self.centerMapOn(coordinate: item.coordinate)
        }).disposed(by: self.disposeBag)
    }

    func drawCircle(centerCoordinate: CLLocationCoordinate2D) {
       let circle = MKCircle(center: centerCoordinate, radius: 200)
       mapView.add(circle)
    }

    func centerMapOn(coordinate: CLLocationCoordinate2D) {
        let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 1500, pitch: 0, heading: 0)
        mapView.setCamera(camera, animated: true)
    }
}

extension VehicleDetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.strokeColor = Theme.Color.darkBlueColor.color
            circleRenderer.fillColor = Theme.Color.lightBlueColor.color
            circleRenderer.lineWidth = 1
            return circleRenderer
        }
        return MKPolylineRenderer()
    }
}

extension VehicleDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            imageViewContainerView.clipsToBounds = scrollView.contentOffset.y == 0
            imageViewTopConstraints.constant = scrollView.contentOffset.y
            return
        }
        imageViewContainerView.clipsToBounds = true
        imageViewTopConstraints.constant = 0
    }
}
