//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by evo on 06/12/21.
//

import UIKit

protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                      AdicionaItensDelegate{

    // MARK: - IBOutlet

    @IBOutlet weak var itensTableView: UITableView!

    // MARK: - Atributos

    var delegate: AdicionaRefeicaoDelegate?
    //var itens: [String] = ["Molho de tomate", "Queijo", "Molho apimentado", "Manjericao"]
    var itens: [Item] = [Item(nome: "Molho de tomate", calorias: 40.0),
                        Item(nome: "Queijo", calorias: 40.0),
                        Item(nome: "Molho apimentado", calorias: 40.0),
                        Item(nome: "Manjericao", calorias: 40.0)]
    var itensSelecionados: [Item] = []

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)

        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]

        celula.textLabel?.text = item.nome

        return celula
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else { return }

        if celula.accessoryType == .none {
            celula.accessoryType = .checkmark

            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])
        } else {
            celula.accessoryType = .none
            let item = itens[indexPath.row]
            if let position = itensSelecionados.firstIndex(of: item) {
                itensSelecionados.remove(at: position)
            }
        }

    }

    // MARK: - IBOutlets

    @IBOutlet weak var nomeTF: UITextField?

    @IBOutlet weak var felicidadeTF: UITextField?

    // MARK: - View life cycle

    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
    }

    @objc func adicionarItens() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }

    func add(_ item: Item) {
        itens.append(item)
        itensTableView.reloadData()
    }

    // MARK: - Actions

    @IBAction func adicionar(_ sender: Any) {
        guard let nomeDaRefeicao = nomeTF?.text else {
            print("nome invalido")
            return
        }

        guard let felicidadeDaRefeicao = felicidadeTF?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            print("felicidade invalida")
            return
        }

        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade)

        refeicao.itens = itensSelecionados

        print("comi \(refeicao.nome) e fiquei com felicidade: \(refeicao.felicidade)")

        delegate?.add(refeicao)

        navigationController?.popViewController(animated: true)
    }
}

