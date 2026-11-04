EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	DECLARE @process_start DATETIME, @process_end DATETIME;
	BEGIN TRY
		SET @process_start = GETDATE();
		PRINT '===================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===================================================';

		PRINT '---------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '---------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT 'crm_cust_info table';
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Projects\Baraa_Project\sql_data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @end_time, @start_time) AS NVARCHAR) + ' seconds';
		PRINT '|||||||||||||||||||||||||||||||||||||||||||||||||||'
		--------------------------------------
		SET @start_time = GETDATE();
		PRINT 'crm_prd_info table';
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Projects\Baraa_Project\sql_data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @end_time, @start_time) AS NVARCHAR) + ' seconds';
		PRINT '|||||||||||||||||||||||||||||||||||||||||||||||||||'
		---------------------------------
		SET @start_time = GETDATE();
		PRINT 'crm_sales_details table';
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Projects\Baraa_Project\sql_data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @end_time, @start_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '---------------------------------------------------';
		-------------------------------
		SET @start_time = GETDATE();
		PRINT 'erp_cust_az12 table';
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Projects\Baraa_Project\sql_data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @end_time, @start_time) AS NVARCHAR) + ' seconds';
		PRINT '|||||||||||||||||||||||||||||||||||||||||||||||||||'
		-------------------------------------
		SET @start_time = GETDATE();
		PRINT 'erp_loc_a101 table';
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Projects\Baraa_Project\sql_data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @end_time, @start_time) AS NVARCHAR) + ' seconds';
		PRINT '|||||||||||||||||||||||||||||||||||||||||||||||||||'
		--------------------------------------
		SET @start_time = GETDATE();
		PRINT 'erp_px_cat_g1v2 table';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Projects\Baraa_Project\sql_data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @end_time, @start_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------';
		PRINT '========================================================'
		PRINT 'Loading Bronze Layer Completed'
		PRINT '========================================================'
		SET @process_end = GETDATE();
		PRINT '>> Bronze Load Duration: '+ CAST(DATEDIFF(second, @process_start, @process_end) AS NVARCHAR) + ' seconds';
	END TRY
	BEGIN CATCH
		PRINT '========================================================'
		PRINT 'ERROR DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '========================================================'
	END CATCH
END