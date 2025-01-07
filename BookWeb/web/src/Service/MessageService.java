package Service;

import Dao.MessageDao;
import Entity.Message;

import java.util.List;

public class MessageService {

 public List<Message> getAllData() {

     MessageDao dao = new MessageDao();
     return dao.getAllData();





 }
}
