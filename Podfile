#platform :ios, "10.0"
use_frameworks!
#inhibit_all_warnings!

def cartrack_pods
    pod "RxSwift", "5.0.0"
    pod "RxCocoa", "5.0.0"
    pod "Alamofire", "4.8.2"
    pod "SwiftyJSON", "5.0.0"
    # Swift Inject
    pod "Swinject", "2.6.2"
    pod "SwinjectStoryboard", "2.2.0"
end

def cartrack_test_pods
    # Unit Testing
    pod "Mockingjay", "3.0.0-alpha.1"
end

target "CartrackTechChallenge" do
    cartrack_pods
end

target "CartrackTechChallengeTests" do
    cartrack_pods
    cartrack_test_pods
end
