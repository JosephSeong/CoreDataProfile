//
//  RandomViewController.swift
//  ToDo
//
//  Created by Joseph on 1/12/24.
//

import UIKit

class RandomViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCatImage()
    }

    private func loadCatImage() {
        let urlString = "https://api.thecatapi.com/v1/images/search"

        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }

            //
            let jsonDecoder = JSONDecoder()
            guard let cats = try? jsonDecoder.decode([Cat].self, from: data),       // 타입 자체를 전달하기 위해서는 self 붙임
                  let cat = cats.first
            else { return }

            //
            guard let url = URL(string: cat.url) else { return }

            let request = URLRequest(url: url)

            //
            URLSession.shared.dataTask(with: request) { data, _, _ in
                guard let data = data else { return }

                //print(cat.url)
                //print(String(data: data, encoding: .utf8))

                let image = UIImage(data: data)

                DispatchQueue.main.sync { [weak self] in
                    self?.imageView.image = image
                }
            }.resume()
        })
        task.resume()
    }
}
