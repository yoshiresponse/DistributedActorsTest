import Distributed
import TicTacFishShared


/// Shared instance of the local networking sample actor system.
///
/// Note also that in `Info.plist` we must define the appropriate NSBonjourServices
/// in order for the peer-to-peer nodes to be able to discover each other.
let localNetworkSystem = SampleLocalNetworkActorSystem()

var internetText : String = "Unknown"


