//
// Sends 10 "hello" messages, 1 per second to specified destination mac address
//
// $src_ip
// $dst_ip
// $src_mac
// $dst_mac
// $dev
//

RatedSource(DATA "hello", RATE 1, LIMIT 10) 
						-> Print(Raw)
                                                -> SetIPHeader(SOURCE_IP 1, DEST_IP 2)
						-> Print(IP)
						-> ToDevice(veth1)
