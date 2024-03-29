#ifndef CLICK_TCPCLIENT_HH
#define CLICK_TCPCLIENT_HH

#include <click/element.hh>
#include <click/timer.hh>
#include "tcpheader.hh"

#define MAXSENDCNT 7
#define MSS 10
#define RECV_BUFSIZE 100

#define CLOSED 0
#define SYN_SENT 1
#define SYN_RECEIVED 2
#define ESTABLISHED 3
#define FIN_WAIT1 4
#define FIN_WAIT2 5
#define CLOSING 6
#define TIMED_WAIT 7
#define CLOSE_WAIT 8
#define LAST_ACK 9
//#define CLOSED 10

#define SYN 1
#define ACK 2
#define SYN_ACK 3
#define PSH 4
#define FIN 5
#define RST 6

#define PACKET_TIMEOUT 2
#define CONNECT_TIMEOUT 5

CLICK_DECLS

class TcpClient : public Element 
{
private:
	int state;
	unsigned ins;
	char *buf;
	int bufoffset;
	int window;
	//int bufnum;
	WritablePacket *cur;
	int sendcnt;
	int filelen;
	int datasentup;
	Timer _timer1;
	Timer _timer2;
	
	unsigned src_port;
	unsigned des_port;
	
	bool bc;
public:
	TcpClient();
	~TcpClient();

	const char *class_name() const { return "TcpClient"; }
	const char *port_count() const { return "2/2"; }

	int configure(Vector<String>&, ErrorHandler*);
	int initialize(ErrorHandler*);
	void push(int port, Packet *);
	void run_timer(Timer *timer);
	void settcpheader(tcpheader* header, unsigned s, unsigned a, uint8_t o, uint8_t f, unsigned);
	uint16_t gettcpchk(const unsigned char *ptr, int size);
	void senddata();
	//void senddata(int offset);
};

CLICK_ENDDECLS

#endif
