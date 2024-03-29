require(library "/home/comnetsii/elements/routerport.click")
rp1 :: RouterPort(DEV veth1, IN_MAC 00:00:00:00:00:01, OUT_MAC 00:00:00:00:00:02)
rp2 :: RouterPort(DEV veth2, IN_MAC 00:00:00:00:00:02, OUT_MAC 00:00:00:00:00:01)

r1 :: MyRouter(IP 1)
r2 :: MyRouter(IP 2)
tcp1::TcpClient(INS 5, SRC_PORT 22, DES_PORT 22, BROADCAST true);
tcp2::TcpClient(INS 20, SRC_PORT 22, DES_PORT 22, BROADCAST true);
tl1 :: TCPRouter()
tl2 :: TCPRouter()
file::FileApp(SEND "/home/comnetsii/test/infile.txt", RECV "/home/comnetsii/test/outfile.txt");

rp1 -> [1]r1[1] ->rp1
rp2 -> [1]r2[1] ->rp2

file[0] -> [0] tcp1 [1] -> Print(From1, -1) -> SetIPHeader(SOURCE_IP 1, DEST_IP 2) -> [1]tl1[0] -> [0] r1 [0] -> [0]tl1[1] -> Print(TO1) -> [1] tcp1 [0] -> [0]file

tcp2[1] -> Print(From2) -> SetIPHeader(SOURCE_IP 2, DEST_IP 1) -> [1]tl2[0]-> [0]r2[0] -> [0]tl2[1]->Print(TO2) -> [1] tcp2 [0] -> Discard

 
FromDevice(veth3) ->  [0] tcp2
