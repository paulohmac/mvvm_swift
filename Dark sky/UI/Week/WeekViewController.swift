//
//  WeekViewController.swift
//  View controler com a listagem de leituras da semana
//  problemas com o UIActivityIndicatorView e a alternativa  SVProgressHUD que também não funciona no IOS 13
//  Created by Paulo Henrique on 16/02/20.
//

import UIKit

class WeekViewController: BaseViewController, WeatherAnimation {
     
    
    @IBOutlet weak var weekConditionsTableView: UITableView!
    
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
     
    lazy var viewModel = WeekViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    /*
    // MARK: - Dados
    */
    
    /// Retorna os dados da camada de viewModel e seta no TableView e tela
    ///
    private func getData(){
        indicator.startAnimating()
        viewModel.getCurrentDailyWeather(completionHandler : { (result) in
            self.indicator.stopAnimating()
            if !result {
                //CustomMsgBox.showMessage(msg: self.viewModel.getErrorMsg() , parent: self)
            }else{
                self.weekConditionsTableView.reloadData()
                self.setWeatherBackground(self.viewModel.getCurrentState())
            }
         })
    }
    
     /*
     // MARK: - Navegacao
     */

    /// Reabre a tela com  leitura atual.
    ///

    @IBAction func openNowScreen(_ sender: Any) {
          openNowView()
    }
    
    

}
/*
// MARK: - Extensão interfaces UitableView
*/
extension WeekViewController: UITableViewDelegate{
}


extension WeekViewController: UITableViewDataSource{

     public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
  
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 96
     }
     /// Baseado nos dados que estão no viewModel, popula a tableview.
     ///
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell;

        cell = (weekConditionsTableView.dequeueReusableCell(withIdentifier: "dailyWeatherCell") as UITableViewCell?)!
        
        if let viewWithTag = cell.viewWithTag(5656) {
            viewWithTag.removeFromSuperview()
        }
        //Seleciona a imagem a ser exibida
        if let imageView = cell.viewWithTag(1) as? UIImageView {
            let temp = self.viewModel.getItemState(indexPath.section)
            print(temp)
            switch temp {
            case .cloudy:
                imageView.image = UIImage(named: "mini_nublado")
            case .heat:
                imageView.image = UIImage(named: "mini_sol")
            case .rain:
                imageView.image = UIImage(named: "mini_chuva")
            case .cold:
                imageView.image = UIImage(named: "mini_fechado")
            }
            //Seta o degrade de background
            cell.setWeatherBackground(temp)
        }

        if let temperatureLbl = cell.viewWithTag(2) as? UILabel {
            temperatureLbl.text = self.viewModel.getItemDate(indexPath.section)
        }

        if let temperatureLbl = cell.viewWithTag(3) as? UILabel {
            temperatureLbl.text = self.viewModel.getTemperatureString(indexPath.section)
        }
        
        if let humidityLbl = cell.viewWithTag(4) as? UILabel {
            humidityLbl.text = self.viewModel.getHumidity(indexPath.section)
        }

        return cell
     }
    
     func numberOfSections(in tableView: UITableView) -> Int {
         return viewModel.countItens()
     }
    
    
}
