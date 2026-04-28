USE CocoaLand_DB;
GO


-- Products Master
ALTER TABLE Products_Master
    ALTER COLUMN Product_ID NVARCHAR(20) NOT NULL;

-- Warehouse Master
ALTER TABLE Warehouse_Master
    ALTER COLUMN Warehouse_ID NVARCHAR(20) NOT NULL;

-- Raw Materials Master
ALTER TABLE Raw_Materials_Master
    ALTER COLUMN Material_ID NVARCHAR(20) NOT NULL;

-- Suppliers
ALTER TABLE Suppliers
    ALTER COLUMN Supplier_ID NVARCHAR(20) NOT NULL;


-- Customer Sales Orders
ALTER TABLE Customer_Sales_Orders
    ALTER COLUMN Sales_Order_ID NVARCHAR(20) NOT NULL;
ALTER TABLE Customer_Sales_Orders
    ALTER COLUMN Product_ID NVARCHAR(20) NOT NULL;


-- Order Shipment Status
ALTER TABLE Order_Shipment_Status
    ALTER COLUMN Sales_Order_ID NVARCHAR(20) NOT NULL;
ALTER TABLE Order_Shipment_Status
    ALTER COLUMN Warehouse_ID NVARCHAR(20) NOT NULL;
ALTER TABLE Order_Shipment_Status
    ALTER COLUMN Shipment_ID NVARCHAR(20) NOT NULL;

-- Purchase Orders
ALTER TABLE Purchase_Orders
    ALTER COLUMN PO_ID NVARCHAR(20) NOT NULL;
ALTER TABLE Purchase_Orders
    ALTER COLUMN Supplier_ID NVARCHAR(20) NOT NULL;

-- Purchase Order Lines
ALTER TABLE Purchase_Order_Lines
    ALTER COLUMN PO_Line_ID NVARCHAR(20) NOT NULL;
ALTER TABLE Purchase_Order_Lines
    ALTER COLUMN PO_ID NVARCHAR(20) NOT NULL;
ALTER TABLE Purchase_Order_Lines
    ALTER COLUMN Material_ID NVARCHAR(20) NOT NULL;

-- Stock Movements
ALTER TABLE Stock_Movements
    ALTER COLUMN Movement_ID NVARCHAR(20) NOT NULL;
ALTER TABLE Stock_Movements
    ALTER COLUMN Material_ID NVARCHAR(20) NOT NULL;
ALTER TABLE Stock_Movements
    ALTER COLUMN Warehouse_ID NVARCHAR(20) NOT NULL;

-- Warehouse Inventory
ALTER TABLE Warehouse_Inventory
    ALTER COLUMN Material_ID NVARCHAR(20) NOT NULL;
ALTER TABLE Warehouse_Inventory
    ALTER COLUMN Warehouse_ID NVARCHAR(20) NOT NULL;




-- ════════════════════════════════════════════════════════════════
-- PRIMARY KEYS
-- ════════════════════════════════════════════════════════════════

ALTER TABLE Products_Master
    ADD CONSTRAINT PK_Products_Master 
    PRIMARY KEY (Product_ID);

ALTER TABLE Warehouse_Master
    ADD CONSTRAINT PK_Warehouse_Master 
    PRIMARY KEY (Warehouse_ID);

ALTER TABLE Raw_Materials_Master
    ADD CONSTRAINT PK_Raw_Materials_Master 
    PRIMARY KEY (Material_ID);

ALTER TABLE Suppliers
    ADD CONSTRAINT PK_Suppliers 
    PRIMARY KEY (Supplier_ID);

ALTER TABLE Purchase_Orders
    ADD CONSTRAINT PK_Purchase_Orders 
    PRIMARY KEY (PO_ID);

ALTER TABLE Purchase_Order_Lines
    ADD CONSTRAINT PK_Purchase_Order_Lines 
    PRIMARY KEY (PO_Line_ID);

ALTER TABLE Stock_Movements
    ADD CONSTRAINT PK_Stock_Movements 
    PRIMARY KEY (Movement_ID);

ALTER TABLE Customer_Sales_Orders
    ADD CONSTRAINT PK_Customer_Sales_Orders 
    PRIMARY KEY (Sales_Order_ID);

ALTER TABLE Order_Shipment_Status
    ADD CONSTRAINT PK_Order_Shipment_Status
    PRIMARY KEY (Shipment_ID);


-- Composite PK for Warehouse Inventory
ALTER TABLE Warehouse_Inventory
    ADD CONSTRAINT PK_Warehouse_Inventory 
    PRIMARY KEY (Material_ID, Warehouse_ID);

-- ════════════════════════════════════════════════════════════════
-- FOREIGN KEYS
-- ════════════════════════════════════════════════════════════════

-- Customer Sales Orders → Products Master
ALTER TABLE Customer_Sales_Orders
    ADD CONSTRAINT FK_SalesOrders_Product
    FOREIGN KEY (Product_ID) 
    REFERENCES Products_Master(Product_ID);

-- Fulfillment Status → Customer Sales Orders
ALTER TABLE Order_Shipment_Status
    ADD CONSTRAINT FK_Order_Shipment_Status_SalesOrder
    FOREIGN KEY (Sales_Order_ID) 
    REFERENCES Customer_Sales_Orders(Sales_Order_ID);

-- Fulfillment Status → Warehouse Master
ALTER TABLE Order_Shipment_Status
    ADD CONSTRAINT FK_Order_Shipment_Status_Warehouse
    FOREIGN KEY (Warehouse_ID) 
    REFERENCES Warehouse_Master(Warehouse_ID);

-- Purchase Orders → Supplier Master
ALTER TABLE Purchase_Orders
    ADD CONSTRAINT FK_PurchaseOrders_Supplier
    FOREIGN KEY (Supplier_ID)
    REFERENCES Suppliers(Supplier_ID);

-- ════════════════════════════════════════════════════════════════
-- VERIFY ALL KEYS
-- ════════════════════════════════════════════════════════════════

SELECT 
    tc.TABLE_NAME,
    tc.CONSTRAINT_NAME,
    tc.CONSTRAINT_TYPE,
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_TYPE IN ('PRIMARY KEY', 'FOREIGN KEY')
ORDER BY tc.TABLE_NAME, tc.CONSTRAINT_TYPE;