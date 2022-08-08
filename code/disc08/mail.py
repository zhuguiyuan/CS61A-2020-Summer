class Email:
    """Every email object has 3 instance attributes: the
    message, the sender name, and the recipient name.
    """
    def __init__(self, msg, sender_name, recipient_name):
        self.msg = msg
        self.sender_name = sender_name
        self.recipient_name = recipient_name


class Server:
    """Each Server has an instance attribute clients, which
    is a dictionary that associates client names with
    client objects.
    """
    def __init__(self):
        self.clients = {}
    
    def send(self, email):
        """Take an email and put is in the inbox of the client
        it is addressed to.
        """
        if email.sender_name in self.clients \
          and email.recipient_name in self.clients:
            self.clients[email.recipient_name].receive(email)
            return True
        return False
    
    def register_client(self, client, client_name):
        """Takes a client object and client_name and adds them
        to the clients instance attribute.
        """
        if not client_name in self.clients:
            self.clients[client_name] = client
            return True
        return False

class Client:
    """Every Client has instance attributes name (which is
    used for addressing emails to the client), server
    (which is used to send emails out to other clients), and
    inbox (a list of all emails the client has received).
    """
    def __init__(self, server, name):
        self.inbox = []
        self.server = server
        self.name = name
        server.register_client(self, name)
    
    def compose(self, msg, recipient_name):
        """Send an email with the given message msg to the
        given recipient client.
        """
        email = Email(msg, self.name, recipient_name)
        return self.server.send(email)
    
    def receive(self, email):
        """Take an email and add it to the inbox of this
        client.
        """
        self.inbox.append(email)
        print("Debug: receive", email, "I am", self.name)
        print("Debug: inbox is now", self.inbox, "I am", self.name)
