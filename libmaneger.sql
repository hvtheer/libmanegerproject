create database libmaneger;
\c libmaneger;
CREATE TABLE IF NOT EXISTS user_info(
    userinfo_id SERIAL NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255)UNIQUE NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(255)UNIQUE NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY(userinfo_id)
);
CREATE TABLE IF NOT EXISTS nhanvien(
    nhanvien_id SERIAL NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL ,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255)UNIQUE NOT NULL,
    address VARCHAR(255)NOT NULL,
    phone VARCHAR(255)UNIQUE NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY(nhanvien_id)
);

CREATE TABLE IF NOT EXISTS book(
    book_id SERIAL NOT NULL,
    book_name VARCHAR(255)UNIQUE NOT NULL,
    type VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    available INTEGER NOT NULL,
    description TEXT NULL,
    PRIMARY KEY(book_id)
);
CREATE TABLE IF NOT EXISTS transaction(
    transaction_id SERIAL NOT NULL,
    userinfo_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    status BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY(transaction_id),
    FOREIGN KEY(userinfo_id) REFERENCES user_info(userinfo_id),
    FOREIGN KEY(book_id) REFERENCES book(book_id)
);

CREATE TABLE IF NOT EXISTS transaction_info(
    transaction_id INTEGER NOT NULL,
    borrowdate DATE NOT NULL DEFAULT CURRENT_DATE,
    duedate DATE NOT NULL DEFAULT CURRENT_DATE + 7,
    PRIMARY KEY(transaction_id),
    FOREIGN KEY(transaction_id) REFERENCES transaction(transaction_id)
);
CREATE TABLE IF NOT EXISTS returnbooks(
    transaction_id INTEGER NOT NULL,
    nhanvien_id INTEGER NOT NULL,
    returndate DATE NOT NULL DEFAULT CURRENT_DATE,
    fines INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY(transaction_id),
    FOREIGN KEY(transaction_id) REFERENCES transaction(transaction_id),
    FOREIGN KEY(nhanvien_id) REFERENCES nhanvien(nhanvien_id)
);
\encoding "utf-8";
INSERT INTO user_info(first_name,last_name,username,password,email,address,phone) values('Thanh','Duong','katanashi03','okebae123','katanashi03@gmail.com','78 197 Hoàng Mai','0329980119');

INSERT INTO user_info(first_name,last_name,username,password,email,address,phone) values('Văn','Thể','hthe1010','vanthe','hthe1010@gmail.com','Hai Bà Trưng, Hà Nội','0388019282');

INSERT INTO user_info(first_name,last_name,username,password,email,address,phone) values('Anh','Thái','anhthaingd','anhthai','anhthaingd@gmail.com','Cầu Giấy, Hà Nội','0622882279');

INSERT INTO nhanvien(first_name,last_name,username,password,email,address,phone) values('Thành','Tiến','ThanhDuong3103','okebae123','thanhtien31032002@gmail.com','78 197 Hoàng Mai','0329980119');

INSERT INTO book(book_name,type,author,available,description) 
values('Tôi tài giỏi, bạn cũng thế','Psychology','Adam Khoo',8,'Được sáng tác bởi một doanh nhân người Singapore tên Adam Khoo. Nội dung của cuốn sách là những chia sẻ về các câu chuyện cũng như phương pháp học tập. Do chính tác giả đã trải nghiệm khi mới ở độ tuổi cấp 2. Chính vì thế cuốn sách giúp cho người đọc có được sự tự tin cũng như ý thức tự lập tốt. Đồng thời làm chủ cho cuộc sống của chính mình. Đây được xem là một trong những cuốn sách nên đọc bởi nó đã được dịch ra với nhiều ngôn ngữ khác nhau và được truyền bá rộng rãi trên khắp thế giới.');

INSERT INTO book(book_name,type,author,available,description) 
values('Đắc nhân tâm','Psychology','Dale Carnegie',10,'Sách có nội dung đưa ra những lời khuyên rất bổ ích trong cách ứng xử. Cách đối nhân xử thế trong cuộc sống hàng ngày giúp cho người đọc hoàn thiện và vươn tới thành công. Chính vì thế bản thân mỗi người nên trang bị cho mình một cuốn sách. Thật sự, Đắc nhân tâm chính là nghệ thuật để thu hút lòng người cũng như thu phục được lòng người, bởi chính sự chân thành của độc giả qua lời văn và ngôn ngữ của tác giả.');


INSERT INTO book(book_name,type,author,available,description) 
values('Tội ác và trừng phạt','Psychology','Dostoevsky',8,'Đây là cuốn sách từng được bình chọn là cuốn sách vĩ đại nhất mọi thời đại, một trong những cuốn sách hay nên đọc. Tội ác và trừng trị có nội dung nói về luật nhân quả trong cuộc sống là một kiệt tác về tình yêu thương giữa con người với nhau. Trong cuộc sống để có thể hòa nhập, thân thiện với nhau. Gạt vỏ mọi thù hằn, và nói về các tội ác nếu đã thực hiện.');


INSERT INTO book(book_name,type,author,available,description) 
values('Nhà giả kim','Psychology','Paulo Coelho',18,'Nhà giả kim như là đang tự thuật trò chuyện với chính bản thân mình. Sách đã chỉ ra được những thứ đơn giản mà sâu sắc nhất trong đời, khi đọc sách mới có thể ngộ ra được. Bởi rất ít ai có thể tự mình nhận ra được điều đó. Trong tác phẩm đem đến cho độc giả sự lạc quan, những điều mơ ước mà con người đôi khi cũng chỉ biết mơ và không dám thực hiện. Quả thật nhà giả kim đã được biết đến trên khắp các nước trên thế giới. Đặc biệt còn được hầu hết các độc giả ở mọi lứa tuổi yêu thích và lựa chọn.');

CREATE OR REPLACE FUNCTION getinfo_allacuser() RETURNS TABLE(name text,email varchar(255),address varchar(255),phone varchar(255))
AS $$
BEGIN
RETURN QUERY SELECT user_info.first_name || ' '|| user_info.last_name as name, user_info.email, user_info.address, user_info.phone 
FROM user_info
WHERE status = TRUE;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION getinfo_acuser(in usernameinput varchar(255)) RETURNS TABLE(name text,email varchar(255),address varchar(255),phone varchar(255))
AS $$
BEGIN
RETURN QUERY SELECT user_info.first_name || ' '|| user_info.last_name as name, user_info.email, user_info.address, user_info.phone 
FROM user_info
WHERE status = TRUE AND user_info.username = usernameinput;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION getinfo_allnhanvien() RETURNS TABLE(name text,email varchar(255),address varchar(255),phone varchar(255))
AS $$
BEGIN
RETURN QUERY SELECT nhanvien.first_name || ' '|| nhanvien.last_name as name, nhanvien.email, nhanvien.address, nhanvien.phone 
FROM nhanvien
WHERE status = TRUE ;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getinfo_nhanvien(in usernameinput varchar(255)) RETURNS TABLE(name text,email varchar(255),address varchar(255),phone varchar(255))
AS $$
BEGIN
RETURN QUERY SELECT nhanvien.first_name || ' '|| nhanvien.last_name as name, nhanvien.email, nhanvien.address, nhanvien.phone 
FROM nhanvien
WHERE status = TRUE AND nhanvien.username = usernameinput; 
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getinfo_availablebook() RETURNS TABLE(name varchar(255),type varchar(255), author varchar(255),available INTEGER)
AS $$
BEGIN
RETURN QUERY SELECT book.book_name , book.type, book.author, book.available 
FROM book
WHERE book.available > 0;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION find_availablebookByname(input_name varchar(255)) RETURNS TABLE(name varchar(255),type varchar(255), author varchar(255),available INTEGER)
AS $$
BEGIN
RETURN QUERY SELECT book.book_name , book.type, book.author, book.available
FROM book
WHERE book.available > 0 AND (SELECT POSITION(input_name IN book.book_name) > 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION find_availablebookBytype(input_type varchar(255)) RETURNS TABLE(name varchar(255),type varchar(255), author varchar(255),available INTEGER)
AS $$
BEGIN
RETURN QUERY SELECT book.book_name , book.type, book.author, book.available
FROM book
WHERE book.available > 0 AND (SELECT POSITION(input_type IN book.type) > 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION find_availablebookByauthor(input_author varchar(255)) RETURNS TABLE(name varchar(255),type varchar(255), author varchar(255),available INTEGER)
AS $$
BEGIN
RETURN QUERY SELECT book.book_name , book.type, book.author, book.available
FROM book
WHERE book.available > 0 AND (SELECT POSITION(input_author IN book.author) > 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION find_transactionbyId(itransaction_id INTEGER) RETURNS TABLE(name text,book_name varchar(255),borrowdate date,duedate date)
AS $$
BEGIN
RETURN QUERY SELECT user_info.first_name || ' ' || user_info.last_name as name, book.book_name, transaction_info.borrowDate, transaction_info.dueDate 
FROM ((transaction inner join transaction_info on transaction_info.transaction_id = transaction.transaction_id) inner join user_info on transaction.userinfo_id = user_info.userinfo_id) inner join book on book.book_id = transaction.book_id 
WHERE user_info.status = TRUE AND transaction.status = FALSE AND itransaction_id = transaction.transaction_id; 
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION findall_actransaction() RETURNS TABLE(transaction_id INTEGER,name text,book_name varchar(255),borrowdate date,duedate date)
AS $$
BEGIN
RETURN QUERY SELECT transaction.transaction_id, user_info.first_name || ' ' || user_info.last_name as name, book.book_name, transaction_info.borrowDate, transaction_info.dueDate 
FROM ((transaction inner join transaction_info on transaction_info.transaction_id = transaction.transaction_id) inner join user_info on transaction.userinfo_id = user_info.userinfo_id) inner join book on book.book_id = transaction.book_id 
WHERE user_info.status = TRUE AND transaction.status = FALSE ;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_transactions() RETURNS TRIGGER
AS $$
BEGIN
        IF 
            (SELECT available from book where book.book_id = NEW.book_id) > 0 AND (select status from user_info where NEW.userinfo_id = user_info.userinfo_id) = TRUE
        THEN 
           UPDATE book SET available = available - 1 WHERE book.book_id = NEW.book_id;
           
           RETURN NEW;
        ELSE
            RETURN NULL;
        END IF;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE TRIGGER add_transactionb BEFORE INSERT ON transaction
FOR EACH ROW
EXECUTE PROCEDURE add_transactions();

CREATE OR REPLACE FUNCTION add_transactionsa() RETURNS TRIGGER
AS $$
BEGIN   
        IF 
            (SELECT available from book where book.book_id = NEW.book_id) > 0 AND (select status from user_info where NEW.userinfo_id = user_info.userinfo_id) = TRUE
        THEN 
           INSERT INTO transaction_info(transaction_id) values (NEW.transaction_id);
           RETURN NEW;    
        END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER add_transactiona AFTER INSERT ON transaction
FOR EACH ROW
EXECUTE PROCEDURE add_transactionsa();

CREATE OR REPLACE FUNCTION return_book() RETURNS TRIGGER
AS $$
BEGIN   
        IF (NEW.returndate - (select duedate from transaction_info WHERE NEW.transaction_id = transaction_info.transaction_id )) > 0 
        THEN 
        NEW.fines =  (NEW.returndate - (select duedate from transaction_info WHERE NEW.transaction_id = transaction_info.transaction_id ))*3000;
        UPDATE user_info SET status = FALSE WHERE user_info.userinfo_id =  (select userinfo_id from transaction where NEW.transaction_id = transaction.transaction_id );
        END IF;

        UPDATE transaction SET status = TRUE WHERE transaction.transaction_id = NEW.transaction_id;
        UPDATE book SET available = available + 1 WHERE book.book_id = (select book_id from transaction where NEW.transaction_id = transaction.transaction_id);
        RETURN NEW; 

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER return_books BEFORE INSERT ON returnbooks
FOR EACH ROW
EXECUTE PROCEDURE return_book();


-- test of insert a transaction
-- INSERT INTO transaction(userinfo_id,book_id) values (1,1);
-- INSERT INTO transaction(userinfo_id,book_id) values (2,3);
-- INSERT INTO transaction(userinfo_id,book_id) values (2,2);
-- test returnbooks 
-- INSERT INTO returnbooks(transaction_id,nhanvien_id) values (1,1);
-- check fines 
-- INSERT INTO returnbooks(transaction_id,nhanvien_id,returndate) values (1,1,'2022-08-06');