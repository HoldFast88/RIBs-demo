//
//  ActorDetailsViewController.swift
//  RIBsTest
//
//  Created by Oleksii Voitenko on 20.11.2021.
//

import RIBs
import RxSwift
import UIKit

protocol ActorDetailsPresentableListener: AnyObject {
    func didSelectItem(at index: Int)
}

final class ActorDetailsViewController: UIViewController, ActorDetailsPresentable, ActorDetailsViewControllable {
    weak var listener: ActorDetailsPresentableListener?
    
    lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .horizontal
        contentStackView.distribution = .fill
        contentStackView.spacing = 16.0
        return contentStackView
    }()
    
    lazy var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFit
        return photoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .monospacedSystemFont(ofSize: 22.0, weight: .semibold)
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    lazy var moviesTableView: UITableView = {
        let moviesTableView = UITableView(frame: view.bounds, style: .insetGrouped)
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        moviesTableView.backgroundColor = .clear
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseId")
        return moviesTableView
    }()
    
    private var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        view.addSubview(contentStackView)
        view.addSubview(moviesTableView)
        contentStackView.addArrangedSubview(photoImageView)
        contentStackView.addArrangedSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 64.0),
            photoImageView.heightAnchor.constraint(equalToConstant: 64.0),
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20.0),
            moviesTableView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 16.0),
            moviesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configure(with actor: Actor, movies: [Movie]) {
        var actor = actor
        photoImageView.image = actor.image
        nameLabel.text = actor.name
        self.movies = movies
        
        moviesTableView.reloadData()
    }
}

extension ActorDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        listener?.didSelectItem(at: indexPath.row)
    }
}

extension ActorDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movies = movies else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId", for: indexPath)
        var movie = movies[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.image = movie.image
        content.text = movie.title
        content.imageProperties.cornerRadius = 10.0
        cell.contentConfiguration = content
        
        return cell
    }
}
