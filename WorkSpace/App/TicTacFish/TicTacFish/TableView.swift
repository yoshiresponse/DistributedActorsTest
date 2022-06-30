import SwiftUI
import TicTacFishShared
import Distributed
import DistributedActors
import Network

/// In this network mode, we discover colleagues on the local network, and join their table to wait.
struct TableView: View {
    
    /// Model
    @StateObject private var model: TableViewModel
    
    /// Local Staff
    let myself: MySelf
    
    init()  {

        /// Init moved
        let model = TableViewModel()
        self._model = .init(wrappedValue: model)
        
        /// Init local Staff, join local network and join local staff
        let myself = LocalStaff(model: model, actorSystem: localNetworkSystem)
        localNetworkSystem.receptionist.checkIn(myself, tag: "KFC")

        self.myself = myself
        model.staff.append(myself)
    
    }
    
    var body: some View {
        Text("Table 2").fontWeight(.bold)
            .font(.largeTitle).task {
            await checkInternet()
        }
        Button {
            Task {
                let item : FoodItem = model.menu[0]
                await myself.whenLocal { myself in
                    await myself.addItem(item: item)
                }
                return
            }
        
        } label: {
            Image(systemName: "plus")
        }
        Text("\(model.tableState.getCount())")
        
        List {
            ForEach(model.tableState.getOrder()) {
                item in Text(item.name)
            }
        }
        
    }

    
}


// - MARK: Minimal logic helpers

extension TableView {

    func checkInternet() async {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                Task{
                    await startSearchingForStaff()

                }
            } else {
                Task {
                    model.removeColleagues(myself: myself)
                }
            }
        }
        
        monitor.start(queue: queue)
    }
    
    /// Start searching for local staff
    func startSearchingForStaff() async {
        guard model.staff == [myself] else {
            return
        }
        /// The local network actor system provides a receptionist implementation that provides us an async sequence
        /// of discovered actors (past and new)
        let listing = await localNetworkSystem.receptionist.listing(of: Colleague.self, tag: "KFC")
        for try await colleague in listing where colleague.id != self.myself.id {
            log("matchmaking", "Found colleague: \(colleague)")
            model.foundColleague(colleague, myself: self.myself, informColleague: true)
        }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView()
    }
}
