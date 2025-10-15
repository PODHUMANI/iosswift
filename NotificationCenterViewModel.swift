//ViewModel to use :-

NotificationCenter.default.post(name:Notification.Name(rawValue:"enter any string name") , object:nil,userInfo:["Key1":"Value1","Key2":"Value2","Key3":"Value3"])

View folder to use

@State var Callended: AnyCancellable? = nil

self.Callended = NotificationCenter.default
                    .publisher(for: NSNotification.Name("enter any string name"))
                    .sink {  notification in
                        let userInfo = notification.userInfo as? [String:Any]
                        var value1 = userInfo?["Key1"] as? String ?? ""
                    }
