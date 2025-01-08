package Service.ReturnBook;

import Dao.*;
import Entity.*;

import java.awt.print.Book;
import java.time.LocalDate;

import static java.lang.Math.max;
import static java.lang.Math.min;

public class CheckRetBookService {
    public int checkRetBook(long bbrID, boolean isDamagedBool, boolean isPaidBool, LocalDate currentDate){
        //根据借阅号，找到BorrowBookRecord实体首先把借阅状态变成“已还”（数据库）,
        // 计算超期天数,如果为0，则没有超期
        BorrowBookRecordDao borrowBookRecordDao = new BorrowBookRecordDao();
        int overdays=  borrowBookRecordDao.FindOverDaysByBbrID( bbrID,  currentDate);

       //写入借阅记录，通过bbrID，修改borrowEnd和borrowStatus
        BorrowBookRecord borrowBookRecord = null;
        BorrowBookRecord borrowBookRecordtmp = borrowBookRecordDao.EditEndStatusByID(bbrID, currentDate);
        if(borrowBookRecordtmp!=null){
            if(borrowBookRecordtmp.getBbrID()==bbrID){
                borrowBookRecord=borrowBookRecordtmp;
            }
        }
        if(borrowBookRecord==null){
            return 1;//借阅记录没有修改成功
        }
        //根据bbr中的readID和BookID找到所有的数据
        //找reader
        ReaderDao readerDao = new ReaderDao();
        Reader readertmp= readerDao.getReaderByID(borrowBookRecord.getReadID());
        Reader reader=null;
        if(readertmp!=null){
            if(readertmp.getReadID()!=null){
                reader=readertmp;
            }
        }
        if(reader==null){
            return 2;//读者信息没有找到
        }
        //找liutonglist
        LiutongDao liutongDao = new LiutongDao();
        Liutong liutong=null;
        Liutong liutongtmp=liutongDao.FindLiutongByBookID(borrowBookRecord.getBookID());
        if(liutongtmp!=null){
            if(liutongtmp.getBookID()!=null){
                liutong=liutongtmp;
            }
        }
        if(liutong==null){
            return 3;//书籍信息没有找到
        }

        int rtn=CheckSFC(reader , liutong , borrowBookRecord, isDamagedBool ,  isPaidBool);
        return rtn;


    }

    /// 检查是否损坏，付款，超期
    public int CheckSFC(Reader reader , Liutong liutong , BorrowBookRecord borrowBookRecord
            , boolean isDamagedBool , boolean isPaidBool ){
        int rtn = 0 ;

        // 计算超期天数,如果为0，则没有超期
        BorrowBookRecordDao borrowBookRecordDao = new BorrowBookRecordDao();
        LocalDate currentDate = LocalDate.now();
        int overdays =  borrowBookRecordDao.FindOverDaysByBbrID( borrowBookRecord.getBbrID() ,  currentDate);

        int score=reader.getCreditPoint();
        WeiGui weiGui = new WeiGui(0 , reader.getName(), reader.getGender(), reader.getReadID(), "");
        if(isDamagedBool){
            score=score-5;
            // 违规1
            weiGui.setBadContent(weiGui.getBadContent() + "[损坏]");
            // 写入报损书单
            DamageListDao damageListDao = new DamageListDao();
            damageListDao.InsertDamageList(new DamageList(liutong.getBookID()
                    , liutong.getTitle(), liutong.getEdition(), reader.getReadID()
                    , reader.getName(), reader.getGender(),"",""));
            // 付款
            if(isPaidBool){

            }
            else{
                score=0;
                // 违规2
                weiGui.setBadContent(weiGui.getBadContent() + "[未缴费]");
            }
        }
        else{
            // 流通库表的bookNum+1
            LiutongDao liutongDao = new LiutongDao();
            liutongDao.addOneBookNuminLiutongList(liutong.getBookID());
        }

        if(overdays>0){
            // 违规3
            weiGui.setBadContent(weiGui.getBadContent() + "[超期]");
            score=score-overdays;
        }
        else{
            score = score + 2 ;
        }

        // 形成违规记录
        if(!weiGui.getBadContent().equals("")){
            WeiGuiDao weiGuiDao = new WeiGuiDao();
            weiGuiDao.InsertWeiGui(weiGui);
        }

        // 修改信誉分和身份
        score=max(0 ,score);
        score=min(100 , score);

        ReaderLevelType readerLevelType = Reader.creditPoingToRlevel(score);

        reader.setCreditPoint(score);
        reader.setReaderLevel(readerLevelType);

        ReaderDao readerDao = new ReaderDao();
        readerDao.updateReaderCPAndRL(reader);
        rtn=4;//成功

        return rtn;
    }
}
