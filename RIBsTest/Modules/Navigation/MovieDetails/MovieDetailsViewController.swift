//
//  MovieDetailsViewController.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs
import RxSwift
import UIKit

protocol MovieDetailsPresentableListener: AnyObject {
    func didSelectItem(at index: Int)
}

final class MovieDetailsViewController: UIViewController, MovieDetailsPresentable, MovieDetailsViewControllable {
    weak var listener: MovieDetailsPresentableListener?
    
    lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.spacing = 16.0
        return contentStackView
    }()
    
    lazy var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFit
        return photoImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .monospacedSystemFont(ofSize: 22.0, weight: .semibold)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var actorsTableView: UITableView = {
        let actorsTableView = UITableView(frame: view.bounds, style: .insetGrouped)
        actorsTableView.translatesAutoresizingMaskIntoConstraints = false
        actorsTableView.backgroundColor = .clear
        actorsTableView.delegate = self
        actorsTableView.dataSource = self
        actorsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseId")
        return actorsTableView
    }()
    
    private var actors: [Actor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        view.addSubview(contentStackView)
        view.addSubview(actorsTableView)
        contentStackView.addArrangedSubview(photoImageView)
        contentStackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: 64.0),
            titleLabel.heightAnchor.constraint(equalToConstant: 32.0),
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8.0),
            actorsTableView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 32.0),
            actorsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            actorsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            actorsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configure(with movie: Movie, actors: [Actor]) {
        var movie = movie
        photoImageView.image = movie.image
        titleLabel.text = movie.title
        self.actors = actors
        
        actorsTableView.reloadData()
    }
}

extension MovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        listener?.didSelectItem(at: indexPath.row)
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actors?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let actors = actors else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId", for: indexPath)
        var actor = actors[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.image = actor.image
        content.text = actor.name
        content.imageProperties.cornerRadius = 10.0
        cell.contentConfiguration = content
        
        return cell
    }
}
