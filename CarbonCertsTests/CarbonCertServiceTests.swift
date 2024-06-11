import XCTest
import Combine
import CombineMoya
import SwiftData
@testable import CarbonCerts

final class CarbonCertServiceTests: XCTestCase {
    var viewModel: CertificatesListViewModel!
    var apiManager: MockCertService!
    var cancellables: Set<AnyCancellable>!
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    
    @MainActor
    override func setUpWithError() throws {
        apiManager = MockCertService()
        // Setup ModelContainer and ModelContext for testing
        modelContainer = try ModelContainer(for: Certificate.self)
        modelContext = ModelContext(modelContainer)
        viewModel = CertificatesListViewModel(certService: apiManager, context: modelContext)
    }
    
    @MainActor
    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = nil
        modelContainer = nil
        modelContext = nil
    }
    
    @MainActor
    func testAppStartsWithNoCertificates() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Certificate.self, configurations: config)
        viewModel.updateContext(container.mainContext)
        // System under test
        let sut = viewModel
        XCTAssertEqual(sut?.certs.count, 0, "There should be 0 certs when the app is first launched.")
    }
    
    @MainActor
    func testSampleCertificatesGetSaved() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Certificate.self, configurations: config)
        viewModel.updateContext(container.mainContext)
        viewModel.addSamples()
        let sut = viewModel.certs
        XCTAssertEqual(sut.count, 3, "There should be 3 sample certs.")
    }
}
