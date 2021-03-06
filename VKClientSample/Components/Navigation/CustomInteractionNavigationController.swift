//
//  CustomInteractionNavigationController.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 13.03.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // Началась ли анимация
    var hasStarted = false
    // Нужно ли закончить анимацию
    var shouldFinish = false
}

class CustomInteractionNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let interactiveTransition = CustomInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let edgePanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(edgePanGestureRecognizer)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .pop:
            return PopAnimator()
        case .push:
            return PushAnimator()
        case .none:
            return nil
        @unknown default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    @objc private func handlePanGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            // Пользователь начал тянуть - стартуем pop-анимацию, и выставляем флаг hasStarted
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
            
        case .changed:
            // Пользователь продолжает тянуть
            // рассчитываем размер экрана
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            // рассчитываем длину перемещения пальца
            let translation = recognizer.translation(in: recognizer.view)
            // рассчитываем процент перемещения пальца относительно размера экрана
            let relativeTranslation = translation.x / width
            let progress = max(0, min(1, relativeTranslation))
            
            // выставляем соответствующий прогресс интерактивной анимации
            interactiveTransition.update(progress)
            interactiveTransition.shouldFinish = progress > 0.33
           
        case .ended:
            // Завершаем анимацию в зависимости от пройденного прогресса
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
            
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
            
        default:
            break
        }
    }
}
