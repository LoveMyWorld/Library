package Entity;

public class Message {
    int messageID;
    String publisher;
    String messageText;


    public Message(int messageID, String publisher, String messageText) {
        this.messageID = messageID;
        this.publisher = publisher;
        this.messageText = messageText;
    }

    public Message() {
    }

    public int getMessageID() {
        return messageID;
    }

    public void setMessageID(int messageID) {
        this.messageID = messageID;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }
}
