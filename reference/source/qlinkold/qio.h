enum SubSystem {
   ssPacket,
   ssTelnet,
   ssQMCP,
};

void qio_register_fd(int fd, enum SubSystem subsystem);
void qio_unregister_fd(int fd);
void qio_process_fds(void);

