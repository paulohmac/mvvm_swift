//
//  NowViewController.swift
//  View que mostra a temperatura atual
//  problemas com o UIActivityIndicatorView e a alternativa  SVProgressHUD que também não funciona no IOS 13
//  Created by Paulo H. Machtura on 15/02/20.
//

import UIKit
import CoreLocation
import SVProgressHUD
class NowViewController: BaseViewController, WeatherAnimation {
    /*
    // MARK: - Iboutlet da tela
    */
    @IBOutlet weak var weatherImg: UIImageView!
    
    @IBOutlet weak var weatherDescriptionLbl: UILabel!
    
    @IBOutlet weak var temperatureLbl: UILabel!
    
    @IBOutlet weak var windSpeedLbl: UILabel!
    
    @IBOutlet weak var humidityLBl: UILabel!
    
    @IBOutlet weak var currentDateLbl: UILabel!
    
    let nubladoImage = "nublado"
    let solImage = "sol"
    let chuvaImage = "chuva"
    let fechadoImage = "fechado"

    //indicator não está funcionando direito
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    lazy var viewModel = NowViewModel()
    
    /// Registra para receber requisição do serviço de Localização e dispara o processo de exibicação de dados.
    ///

    override func viewDidLoad() {
        super.viewDidLoad()
        confiIndicator()
        indicator.startAnimating()
        NotificationCenter.default.addObserver(self, selector:  #selector(configScreen(_:)), name: NSNotification.Name(rawValue: DarkSkyLocation.kLocationDidChangeNotification), object: nil)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    
    @objc func configScreen(_ notification: NSNotification) {
        indicator.stopAnimating()
        getData()
    }

    
    private func confiIndicator(){
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = view.center
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
    }
    /// retorna dados da API
    ///
    private func getData(){
        indicator.startAnimating()
        viewModel.getCurrentWeather(completionHandler : { (result) in
            self.indicator.stopAnimating()
            if !result {
                //CustomMsgBox.showMessage(msg: self.viewModel.getErrorMsg() , parent: self)
            }else{
                self.setData()
            }
         })
    }
    
    /// Seta os dados nos componentes.
    ///
    private func setData(){
        weatherDescriptionLbl.text = viewModel.getCondition()?.currently?.summary
        temperatureLbl.text = viewModel.getTemperatureString()
        windSpeedLbl.text = viewModel.getWindSpeed()
        humidityLBl.text = viewModel.getHumidity()
        currentDateLbl.text = viewModel.getCurrentDate()
        setImageWeather()
    }
    /// Seta a imagem principal representando a temperatura.
    ///
    func setImageWeather(){
        let currentTemp = viewModel.getCurrentState()
        switch currentTemp {
        case .cloudy:
            weatherImg.image = UIImage(named: nubladoImage)
        case .heat:
            weatherImg.image = UIImage(named: solImage)
        case .rain:
            weatherImg.image = UIImage(named: chuvaImage)
        case .cold:
            weatherImg.image = UIImage(named: fechadoImage)
        }
        setupBackground(currentTemp)
    }
    /// Setá o background degrade com animação de transição.
    ///
    private func setupBackground(_ temperature : Temperature){
        setWeatherBackground(temperature)
    }
  
    
    @IBAction func openWeekScreen(_ sender: Any) {
        openWeekView()
    }
    
 
    
 
}


