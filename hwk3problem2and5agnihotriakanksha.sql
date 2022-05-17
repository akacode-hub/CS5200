/* Answers for the question 2 and 5 homework 3 
2.a	How many databases are created by the script?
Answers 2.a: 3 databases are created .


2.b	List the database names and the tables created for each database.
Answers 2.b: 
Database name: ap 
Database table names: general_ledger_accounts, invoice_archive, invoice_line_items, invoices, terms, vendor_contacts, vendors. 
Database name : ex
Database table names : active_invoices, color_sample, customers, date_sample, departments, employees, float_sample, null_sample, paid_invoices, projects, string_sample
Database name : om
Database table names : customers, items, order_details, orders 

2.c	How many records does the script insert into the om.order_details table?
Answers 2.c :  68
 by implementing : */select count(order_id) from om.order_details; 
 
/*2.d.How many records does the script insert into the ap.invoices table?
Answers 2.d : 114
  by implementing : */select count(invoice_id) from ap.invoices;
  
/*2.e.How many records does the script insert into the ap.vendors table?
Answers 2.e : 122
  by implementing :*/ select count(vendor_id) from ap.vendors;
  
/*2.f.Is there a foreign key between the ap.invoices and the ap.vendors table?
Answers 2.f : Yes there are foreign keys in ap.vendors and in ap.invoices . 
vendors_fk_terms , vendors_fk_accounts  are foreign key names in the vendors invoices_fk_terms , invoices_fk_vendors  are the foreign keys in the invoices . 

2.g.How many foreign keys does the ap.vendors table have?
Answer 2.g : There are 2 foreign keys . vendors_fk_terms , vendors_fk_accounts  are foreign key names in the vendors. 

2.h.What is the primary key for the om.customers table?
Answer 2.h: customer_id is the primary key of the customer .
 
/*2.i. Write a SQL command that will retrieve all values for all fields from the orders table
Answer 2.i : */select * from om.orders;

/* 2.j.Write a SQL command that will retrieve the fields: title and artist from the om.items table
Answer2.j :*/  select title,artist from om.items;


/*5.a.How many tables are created by the script?
Answers5.a : 11 tables 

5.b.List the names of the tables created for the Chinook database.
Answers 5.b: Album , Artist , Customer , Employee , Genre, Invoice , InvoiceLine, MediaType, Playlist , PlaylistTrack , Track 

5.c.	How many records does the script insert into the Album table?
Answers 5.c : 347 
 by implementing :*/ select count(AlbumId) from chinook.Album;

/*5.d.	What is the primary key for the Album table?
Answers 5.d : AlbumId is the primary key 

5.e.	Write a SQL SELECT command to retrieve all data from all columns and rows in the Artist table.
Answers 5.e :*/  select * from chinook.Artist; 

/*5.f.	Write a SQL SELECT command to retrieve the fields FirstName, LastName and Title from the Employee table
Answers 5.f : */ select FirstName, LastName , Title from chinook.Employee;





