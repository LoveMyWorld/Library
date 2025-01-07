package Service;

import Dao.MessageDao;
import Entity.Message;

import java.util.List;

public class MessageService {

 public List<Message> getAllData() {

     MessageDao dao = new MessageDao();
     return dao.getAllData();

 }

    public int maxID() {

     MessageDao dao = new MessageDao();
     return dao.getMaxID();
    }

    public void addLine(Message message) {
        MessageDao dao = new MessageDao();
        dao.addLine(message);


 }
}
