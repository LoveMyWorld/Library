package Service;

import Dao.AppointmentDao;
import Dao.BorrowBookRecordDao;
import Dao.LiutongDao;
import Dao.ReaderDao;
import Entity.*;

import java.time.LocalDate;

public class DirBorrowSevice {

    //如果不是黑名单用户，看这本书是否还有库存（预约表和流通库表）
    boolean isHaveBook(String bookID) {
        //找一条记录
        LiutongDao liutongDao = new LiutongDao();
        int bookInLiutong = liutongDao.FindBookNumByBookID(bookID);
        //找多条记录
        AppointmentDao appointmentDao = new AppointmentDao();
        int bookInappointment = appointmentDao.Ap_FindBookNumByBookID(bookID);
        //比较,至少有一本可以借出去，所以是大于
        if (bookInLiutong > bookInappointment) {
            return true;
        } else {
            return false;
        }
    }

    public int checkDirBorrow(String readID, String bookID, LocalDate currentDate) {
        //看读者资质是否合格
        //即为看读者是否为黑名单用户，通过输入的readID，找到读者的library.readerLevel对应的borrowDay
        BorrowBookRecordDao borrowBookRecordDao = new BorrowBookRecordDao();
        int borrowDay = borrowBookRecordDao.getBorrowDayByReaderID(readID);
        if (borrowDay == 0) {
            return 1;//代表读者不存在或者在黑名单用户
        }
        //如果不是黑名单用户，看这本书是否还有库存（预约表和流通库表）
        boolean isHas = false;
        isHas = isHaveBook(bookID);
        if (!isHas) {
            return 2;//说明没有多余的可借书了，预约表借该书的总数小于等于流通库表
        }
        //什么条件都满足，太棒了，可以愉快地借书了
        //流通库表书目减一
        LiutongDao liutongDao = new LiutongDao();
        int isUpdate=liutongDao.updateLiutongList(bookID);
        if(isUpdate!=1){
            return 3;//此时是：有书可以借出，但是流通库表没有更新成功或者流通
        }
        //借阅记录写进去,把手写的借阅登记写入借阅记录
        //其实我这里写的有点浪费时间，不过函数里面能复用，也蛮好的，borrowDay这时已经得到了，却还是又建了
        boolean isWriteBorrowBookRecord= borrowBookRecordDao.mIntoBorrowBookRecord(readID, bookID, currentDate);
        //
        if(!isWriteBorrowBookRecord){
            return 4;//数据库操作失败，该借阅登记未正常写入借阅记录，请注意：流通库表减了一本书，但这本书却没借阅记录
        }
        return 5;//正确的成功返回


    }
    public DisplayBorrowBookMsg dispalyBorrowBook(String readID, String bookID) {
        ReaderDao readerDao = new ReaderDao();
        Reader reader = readerDao.getReaderByID(readID);
        DisplayBorrowBookMsg displayBorrowBookMsg = new DisplayBorrowBookMsg();
        if (reader != null) {
            LiutongDao liutongDao = new LiutongDao();
            Liutong liutong = liutongDao.FindLiutongByBookID(bookID);
            if (liutong != null) {

                displayBorrowBookMsg.setReadID(reader.getReadID());
                displayBorrowBookMsg.setBookID(liutong.getBookID());
                displayBorrowBookMsg.setAuthor(liutong.getAuthor());
                displayBorrowBookMsg.setTitle(liutong.getTitle());
                displayBorrowBookMsg.setEdition(liutong.getEdition());
                displayBorrowBookMsg.setPhoneNum(reader.getPhoneNum());
                displayBorrowBookMsg.setName(reader.getName());
                displayBorrowBookMsg.setGender(reader.getGender());

                displayBorrowBookMsg.setMsg(1);//1是成功
                return displayBorrowBookMsg;
            }
            displayBorrowBookMsg.setMsg(2);//流通库表没书
            return displayBorrowBookMsg;
        }
        displayBorrowBookMsg.setMsg(3);//此人不是读者

        return displayBorrowBookMsg;
    }
}





