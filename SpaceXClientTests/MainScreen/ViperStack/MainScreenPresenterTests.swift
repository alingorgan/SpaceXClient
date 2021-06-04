//
//  MainScreenPresenterTests.swift
//  SpaceXClientTests
//
//  Created by Alin Gorgan on 6/4/21.
//

@testable import SpaceXClient
import XCTest

final class MainScreenPresenterTests: XCTestCase {
    
    var spyView: SpyMainScreenView!
    var mockInteractor: MockMainScreenInteractor!
    var mockQueue: MockDispatchQueue!
    var subject: MainScreenPresenter!
    
    override func setUp() {
        super.setUp()
        
        spyView = SpyMainScreenView()
        mockInteractor = MockMainScreenInteractor()
        mockQueue = MockDispatchQueue()
        subject = MainScreenPresenter(
            view: spyView,
            interactor: mockInteractor,
            mainQueue: mockQueue,
            globalQueue: mockQueue)
    }
    
    override func tearDown() {
        spyView = nil
        mockInteractor = nil
        mockQueue = nil
        subject = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad_viewIsLoading_viewmodelIsUpdated() {
        subject.viewDidLoad()
        
        XCTAssertEqual(spyView.callRecord.first, .didSetViewModel(.loadingData))
    }
    
    func test_viewDidLoad_companyInfoIsLoaded_viewModelIsUpdated() {
        let stubCompanyInfo = CompanyInfoDataModel.stub()
        mockInteractor.stubCompanyInfoResult = .success(stubCompanyInfo)
        
        subject.viewDidLoad()
        
        XCTAssertEqual(mockInteractor.callRecord.first, .loadCompanyInfo)
        
        guard case .didSetViewModel(let viewModel) = spyView.callRecord[1] else {
            XCTFail("Expected view model to be set")
            return
        }
        
        let expectedCompanyInfo = CompanyInfo(dataModel: stubCompanyInfo)
        XCTAssertEqual(viewModel.companyInfo, expectedCompanyInfo)
    }
    
    func test_viewDidLoad_launchInfoIsLoaded_viewModelIsUpdated() {
        let stubCompanyInfo = CompanyInfoDataModel.stub(name: "Test")
        let stubLaunchInfo = [LaunchInfoDataModel.stub(name: "Test")]
        let stubRocketInfo = RocketInfoDataModel.stub(name: "Test")
        
        mockInteractor.stubCompanyInfoResult = .success(stubCompanyInfo)
        mockInteractor.stubLaunchInfoResult = .success(stubLaunchInfo)
        mockInteractor.stubRocketInfoResult = .success(stubRocketInfo)
        
        let expectedLaunches: [LaunchInfo] = stubLaunchInfo.map {
            .init(dataModel: $0, rocketInfoDataModel: stubRocketInfo)
        }
        
        subject.viewDidLoad()
        
        XCTAssertEqual(mockInteractor.callRecord[1], .loadLaunches)
        
        guard case .didSetViewModel(let viewModel) = spyView.callRecord[2] else {
            XCTFail("Expected view model to be set")
            return
        }
        
        XCTAssertEqual(viewModel.launches, expectedLaunches)
    }
}
