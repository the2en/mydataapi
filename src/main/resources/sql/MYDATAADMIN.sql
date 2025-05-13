-- DROP USER MYDATAADMIN;
CREATE USER MYDATAADMIN
-- IDENTIFIED BY <password>
;

CREATE SCHEMA IF NOT EXISTS mydataadmin;

CREATE TABLE mydataadmin.api_mst (
    api_type VARCHAR(2) NOT NULL,
    api_id VARCHAR(10) NOT NULL,
    idst_type VARCHAR(10) NOT NULL,
    scope VARCHAR(20) NOT NULL,
    request_type VARCHAR(1),
    idst_bm VARCHAR(30) NOT NULL,
    api_nm VARCHAR(30) NOT NULL,
    api_content VARCHAR(200),
    api_url_resource VARCHAR(200),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    CONSTRAINT api_mst_pk PRIMARY KEY (api_type, api_id, idst_type)
);
;
CREATE TABLE mydataadmin.bank_acc (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    seqno VARCHAR(7),
    is_foreign_deposit VARCHAR(1),
    prod_name VARCHAR(900) NOT NULL,
    is_minus VARCHAR(1),
    account_type VARCHAR(4) NOT NULL,
    account_status VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_acc_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.bank_acc_deposit (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7),
    currency_code VARCHAR(3),
    saving_method VARCHAR(2) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    exp_date VARCHAR(8),
    commit_amt NUMERIC(18, 0),
    monthly_paid_in_amt NUMERIC(18, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_acc_deposit_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno
    )
);
;
CREATE TABLE mydataadmin.bank_acc_deposit_add (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7),
    currency_code VARCHAR(3),
    balance_amt NUMERIC(18, 0) NOT NULL,
    withdrawable_amt NUMERIC(18, 0) NOT NULL,
    offered_rate NUMERIC(7, 0) NOT NULL,
    last_paid_in_cnt VARCHAR(6),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_acc_deposit_add_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno
    )
);
;
CREATE TABLE mydataadmin.bank_acc_deposit_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7),
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    trans_type VARCHAR(2) NOT NULL,
    trans_class VARCHAR(45) NOT NULL,
    currency_code VARCHAR(6),
    trans_amt NUMERIC(18, 0) NOT NULL,
    balance_amt NUMERIC(18, 0) NOT NULL,
    paid_in_cnt VARCHAR(6),
    trans_memo VARCHAR(210),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL
);

CREATE UNIQUE INDEX bank_acc_deposit_hist_pk ON mydataadmin.bank_acc_deposit_hist (
    member_id,
    org_cd,
    account_num,
    seqno,
    trans_dtime DESC,
    trans_no DESC
);

CREATE TABLE mydataadmin.bank_acc_each_prod (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    prod_name VARCHAR(900) NOT NULL,
    prod_num VARCHAR(64),
    prod_type VARCHAR(2) NOT NULL,
    currency_code VARCHAR(3),
    eval_amt NUMERIC(18, 0) NOT NULL,
    principal_amt NUMERIC(18, 0) NOT NULL,
    holding_num NUMERIC(18, 0),
    issue_date VARCHAR(8),
    exp_date VARCHAR(8),
    int_rate NUMERIC(5, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_acc_each_prod_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        prod_name,
        prod_num
    )
);
;
CREATE TABLE mydataadmin.bank_acc_fund (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7),
    standard_fund_code VARCHAR(12) NOT NULL,
    paid_in_type VARCHAR(2) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    exp_date VARCHAR(8),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_acc_fund_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno,
        standard_fund_code,
        paid_in_type
    )
);
;
CREATE TABLE mydataadmin.bank_acc_fund_add (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7),
    currency_code VARCHAR(3),
    balance_amt NUMERIC(18, 0) NOT NULL,
    eval_amt NUMERIC(18, 0) NOT NULL,
    inv_principal NUMERIC(18, 0) NOT NULL,
    fund_num NUMERIC(18, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_acc_fund_add_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno
    )
);
;
CREATE TABLE mydataadmin.bank_acc_fund_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7),
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    trans_type VARCHAR(2) NOT NULL,
    currency_code VARCHAR(3),
    base_amt NUMERIC(18, 0),
    trans_fund_num NUMERIC(18, 0),
    trans_amt NUMERIC(18, 0) NOT NULL,
    balance_amt NUMERIC(18, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL
);

CREATE UNIQUE INDEX bank_acc_fund_hist_pk ON mydataadmin.bank_acc_fund_hist (
    member_id,
    org_cd,
    account_num,
    seqno,
    trans_dtime DESC,
    trans_no DESC
);

CREATE TABLE mydataadmin.bank_acc_loan (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7),
    issue_date VARCHAR(8) NOT NULL,
    exp_date VARCHAR(8) NOT NULL,
    last_offered_rate NUMERIC(7, 0) NOT NULL,
    repay_date VARCHAR(2),
    repay_method VARCHAR(2) NOT NULL,
    repay_org_code VARCHAR(8),
    repay_account_num VARCHAR(20),
    unredeemed_start VARCHAR(6),
    unredeemed_end VARCHAR(6),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_acc_loan_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno
    )
);
;
CREATE TABLE mydataadmin.bank_acc_loan_add (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7),
    currency_code VARCHAR(3),
    balance_amt NUMERIC(18, 0) NOT NULL,
    loan_principal NUMERIC(18, 0) NOT NULL,
    next_repay_date VARCHAR(8),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_acc_loan_add_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno
    )
);
;
CREATE TABLE mydataadmin.bank_acc_loan_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7),
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    trans_type VARCHAR(2) NOT NULL,
    currency_code VARCHAR(3),
    trans_amt NUMERIC(18, 0) NOT NULL,
    balance_amt NUMERIC(18, 0) NOT NULL,
    principal_amt NUMERIC(18, 0) NOT NULL,
    int_amt NUMERIC(18, 0) NOT NULL,
    ret_int_amt NUMERIC(18, 0),
    int_cnt VARCHAR(3) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL
);

CREATE UNIQUE INDEX bank_acc_loan_hist_pk ON mydataadmin.bank_acc_loan_hist (
    member_id,
    org_cd,
    account_num,
    seqno,
    trans_dtime DESC,
    trans_no DESC
);

CREATE TABLE mydataadmin.bank_acc_loan_hist_int (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7),
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    trans_type VARCHAR(2) NOT NULL,
    int_start_date VARCHAR(8),
    int_end_date VARCHAR(8) NOT NULL,
    int_rate NUMERIC(18, 0) NOT NULL,
    applied_int_amt NUMERIC(18, 0) NOT NULL,
    int_type VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_acc_loan_hist_int_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno,
        trans_dtime,
        trans_no,
        trans_type,
        int_start_date,
        int_end_date
    )
);
;
CREATE TABLE mydataadmin.bank_acc_prod (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    currency_code VARCHAR(3),
    balance_amt NUMERIC(18, 0) NOT NULL,
    eval_amt NUMERIC(18, 0) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    exp_date VARCHAR(8) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_acc_prod_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.bank_acc_prod_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    trans_dtime VARCHAR(14),
    trans_no VARCHAR(64) NOT NULL,
    trans_type VARCHAR(2) NOT NULL,
    currency_code VARCHAR(3) NOT NULL,
    trans_amt NUMERIC(18, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL
);

CREATE UNIQUE INDEX bank_acc_prod_hist_pk ON mydataadmin.bank_acc_prod_hist (
    member_id,
    org_cd,
    account_num,
    trans_dtime DESC,
    trans_no DESC
);

CREATE TABLE mydataadmin.bank_auto_trans (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    scheduled_org_code VARCHAR(8) NOT NULL,
    scheduled_account_num VARCHAR(20) NOT NULL,
    scheduled_amt NUMERIC(18, 0) NOT NULL,
    scheduled_cycle VARCHAR(2) NOT NULL,
    scheduled_date VARCHAR(2),
    trans_memo VARCHAR(180),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_auto_trans_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        scheduled_org_code,
        scheduled_account_num,
        scheduled_amt,
        scheduled_cycle,
        scheduled_date
    )
);
;
CREATE TABLE mydataadmin.bank_cust (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    reg_date VARCHAR(8) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bank_cust_pk PRIMARY KEY (member_id, org_cd, reg_date)
);
;
CREATE TABLE mydataadmin.bond (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    bond_num VARCHAR(348) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    bond_type VARCHAR(2) NOT NULL,
    takeover_date VARCHAR(8) NOT NULL,
    init_org_code VARCHAR(180),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bond_pk PRIMARY KEY (member_id, org_cd, bond_num)
);
;
CREATE TABLE mydataadmin.bond_bal (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    bond_num VARCHAR(348) NOT NULL,
    prev_org_code VARCHAR(180) NOT NULL,
    is_debt_mgmt VARCHAR(1) NOT NULL,
    repay_method VARCHAR(2),
    balance_amt NUMERIC(15, 0) NOT NULL,
    bond_principal NUMERIC(15, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bond_bal_pk PRIMARY KEY (member_id, org_cd, bond_num)
);
;
CREATE TABLE mydataadmin.bond_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    bond_num VARCHAR(348) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    trans_amt VARCHAR(15) NOT NULL,
    balance_amt NUMERIC(15, 0),
    int_amt NUMERIC(18, 0),
    principal_amt NUMERIC(18, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT bond_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        bond_num,
        trans_dtime
    )
);
;
CREATE TABLE mydataadmin.card (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    card_id VARCHAR(64) NOT NULL,
    card_num VARCHAR(19) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    card_name VARCHAR(900) NOT NULL,
    card_member VARCHAR(1) NOT NULL,
    card_type VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_pk PRIMARY KEY (member_id, org_cd, card_id)
);
;
CREATE TABLE mydataadmin.card_apr_dm_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    approved_dtime VARCHAR(14) NOT NULL,
    approved_num VARCHAR(21) NOT NULL,
    status VARCHAR(2) NOT NULL,
    pay_type VARCHAR(2) NOT NULL,
    trans_dtime VARCHAR(14),
    merchant_name VARCHAR(225),
    merchant_regno VARCHAR(12),
    approved_amt NUMERIC(15, 0) NOT NULL,
    modified_amt NUMERIC(15, 0),
    total_install_cnt NUMERIC(5, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_apr_dm_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        approved_dtime,
        approved_num
    )
);
;
CREATE TABLE mydataadmin.card_apr_os_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    approved_dtime VARCHAR(14) NOT NULL,
    approved_num VARCHAR(21) NOT NULL,
    status VARCHAR(2) NOT NULL,
    pay_type VARCHAR(2) NOT NULL,
    trans_dtime VARCHAR(14),
    merchant_name VARCHAR(225),
    approved_amt NUMERIC(18, 0) NOT NULL,
    modified_amt NUMERIC(18, 0),
    country_code VARCHAR(2),
    currency_code VARCHAR(3) NOT NULL,
    krw_amt NUMERIC(15, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_apr_os_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        approved_dtime,
        approved_num,
        status
    )
);
;
CREATE TABLE mydataadmin.card_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    card_id VARCHAR(64) NOT NULL,
    is_trans_payable VARCHAR(1) NOT NULL,
    is_cash_card VARCHAR(1) NOT NULL,
    linked_bank_code VARCHAR(8),
    account_num VARCHAR(20),
    card_brand VARCHAR(3) NOT NULL,
    annual_fee NUMERIC(15, 0) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_base_pk PRIMARY KEY (member_id, org_cd, card_id)
);
;
CREATE TABLE mydataadmin.card_charge (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    seqno VARCHAR(90),
    charge_amt NUMERIC(15, 0) NOT NULL,
    charge_day VARCHAR(2) NOT NULL,
    charge_month VARCHAR(6) NOT NULL,
    paid_out_date VARCHAR(8) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_charge_pk PRIMARY KEY (member_id, org_cd, seqno)
);
;
CREATE TABLE mydataadmin.card_charge_add (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    seqno VARCHAR(90),
    charge_month VARCHAR(6) NOT NULL,
    card_id VARCHAR(64) NOT NULL,
    paid_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    paid_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    merchant_name VARCHAR(225),
    merchant_regno VARCHAR(12),
    credit_fee_amt NUMERIC(15, 0) NOT NULL,
    total_install_cnt NUMERIC(5, 0),
    cur_install_cnt NUMERIC(5, 0),
    balance_amt NUMERIC(15, 0),
    prod_type VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_charge_add_pk PRIMARY KEY (
        member_id,
        org_cd,
        seqno,
        charge_month,
        card_id,
        paid_dtime,
        trans_no
    )
);
;
CREATE TABLE mydataadmin.card_dm_pca (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    card_id VARCHAR(64) NOT NULL,
    purchase_num VARCHAR(32) NOT NULL,
    purchase_date VARCHAR(8) NOT NULL,
    sales_date VARCHAR(8),
    pri_approved_num VARCHAR(21),
    pri_approved_dtime VARCHAR(14),
    pri_approved_amt NUMERIC(18, 0),
    pay_type VARCHAR(2) NOT NULL,
    merchant_name VARCHAR(225),
    merchant_regno VARCHAR(12),
    approved_amt NUMERIC(18, 0) NOT NULL,
    total_install_cnt NUMERIC(5, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_dm_pca_pk PRIMARY KEY (
        member_id,
        org_cd,
        card_id,
        purchase_num
    )
);
;
CREATE TABLE mydataadmin.card_loan (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    is_loan_short_term VARCHAR(1) NOT NULL,
    is_loan_long_term VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_loan_pk PRIMARY KEY (
        member_id,
        org_cd,
        is_loan_short_term,
        is_loan_long_term
    )
);
;
CREATE TABLE mydataadmin.card_loan_lg (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    loan_num VARCHAR(20) NOT NULL,
    loan_dtime VARCHAR(14) NOT NULL,
    loan_cnt NUMERIC(5, 0),
    loan_type VARCHAR(15),
    loan_name VARCHAR(900) NOT NULL,
    loan_amt NUMERIC(18, 0) NOT NULL,
    int_rate NUMERIC(5, 0) NOT NULL,
    exp_date VARCHAR(8) NOT NULL,
    balance_amt NUMERIC(18, 0) NOT NULL,
    repay_method VARCHAR(2) NOT NULL,
    int_amt NUMERIC(18, 0) NOT NULL,
    repay_org_code VARCHAR(10),
    repay_account_num VARCHAR(20),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_loan_lg_pk PRIMARY KEY (
        member_id,
        org_cd,
        loan_num,
        loan_dtime,
        loan_cnt
    )
);
;
CREATE TABLE mydataadmin.card_loan_lg_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    loan_num VARCHAR(20) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    trans_type VARCHAR(2) NOT NULL,
    currency_code VARCHAR(3),
    trans_amt NUMERIC(18, 0) NOT NULL,
    balance_amt NUMERIC(18, 0),
    principal_amt NUMERIC(18, 0) NOT NULL,
    int_amt NUMERIC(18, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_loan_lg_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        loan_num,
        trans_dtime,
        trans_no
    )
);
;
CREATE TABLE mydataadmin.card_loan_st (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    loan_dtime VARCHAR(14) NOT NULL,
    loan_amt NUMERIC(15, 0) NOT NULL,
    balance_amt NUMERIC(15, 0) NOT NULL,
    pay_due_date VARCHAR(8) NOT NULL,
    int_rate NUMERIC(5, 0) NOT NULL,
    repay_org_code VARCHAR(10),
    repay_account_num VARCHAR(20),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_loan_st_pk PRIMARY KEY (member_id, org_cd, loan_dtime)
);
;
CREATE TABLE mydataadmin.card_os_pca (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    card_id VARCHAR(64) NOT NULL,
    purchase_num VARCHAR(32) NOT NULL,
    purchase_date VARCHAR(8) NOT NULL,
    sales_date VARCHAR(8),
    pri_approved_num VARCHAR(21),
    pri_approved_dtime VARCHAR(14),
    pri_approved_amt NUMERIC(18, 0),
    pri_krw_amt NUMERIC(15, 0),
    pri_currency_code VARCHAR(3),
    pay_type VARCHAR(2) NOT NULL,
    merchant_name VARCHAR(225),
    approved_amt NUMERIC(18, 0) NOT NULL,
    country_code VARCHAR(2),
    currency_code VARCHAR(3) NOT NULL,
    krw_amt NUMERIC(15, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_os_pca_pk PRIMARY KEY (
        member_id,
        org_cd,
        card_id,
        purchase_num
    )
);
;
CREATE TABLE mydataadmin.card_pay (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    is_revolving VARCHAR(1) NOT NULL,
    pay_cnt NUMERIC(3, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_pay_pk PRIMARY KEY (member_id, org_cd)
);
;
CREATE TABLE mydataadmin.card_pay_detail (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    seqno VARCHAR(30),
    pay_due_date VARCHAR(8) NOT NULL,
    pay_amt NUMERIC(15, 0) NOT NULL,
    lump_sum_amt VARCHAR(18) NOT NULL,
    monthly_amt VARCHAR(18) NOT NULL,
    loan_short_amt VARCHAR(18) NOT NULL,
    revolving_amt VARCHAR(18) NOT NULL,
    loan_long_amt VARCHAR(18) NOT NULL,
    etc_amt VARCHAR(18) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_pay_detail_pk PRIMARY KEY (
        member_id,
        org_cd,
        seqno,
        pay_due_date
    )
);
;
CREATE TABLE mydataadmin.card_pt (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    point_name VARCHAR(180) NOT NULL,
    remain_point_amt NUMERIC(12, 0) NOT NULL,
    expiring_point_amt NUMERIC(12, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_pt_pk PRIMARY KEY (member_id, org_cd, point_name)
);
;
CREATE TABLE mydataadmin.card_rv (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    req_date VARCHAR(8) NOT NULL,
    end_date VARCHAR(8) NOT NULL,
    close_date VARCHAR(8),
    min_pay_rate NUMERIC(6, 0) NOT NULL,
    min_pay_amt NUMERIC(15, 0) NOT NULL,
    agreed_pay_rate NUMERIC(6, 0),
    agreed_pay_amt NUMERIC(15, 0),
    remained_amt NUMERIC(15, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT card_rv_pk PRIMARY KEY (
        member_id,
        org_cd,
        req_date,
        end_date
    )
);
;
CREATE TABLE mydataadmin.db (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    is_running_pension VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT db_pk PRIMARY KEY (
        member_id,
        org_cd,
        is_running_pension
    )
);
;
CREATE TABLE mydataadmin.dc (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    dc_num VARCHAR(15) NOT NULL,
    dc_name VARCHAR(900) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT dc_pk PRIMARY KEY (member_id, org_cd, dc_num)
);
;
CREATE TABLE mydataadmin.dc_add (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    dc_num VARCHAR(15) NOT NULL,
    prod_name VARCHAR(900) NOT NULL,
    prod_num VARCHAR(64) NOT NULL,
    prod_type VARCHAR(2) NOT NULL,
    eval_amt NUMERIC(18, 0) NOT NULL,
    principal_amt NUMERIC(18, 0) NOT NULL,
    holding_num NUMERIC(18, 0),
    issue_date VARCHAR(8),
    exp_date VARCHAR(8),
    int_rate NUMERIC(5, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT dc_add_pk PRIMARY KEY (
        member_id,
        org_cd,
        dc_num,
        prod_name,
        prod_num
    )
);
;
CREATE TABLE mydataadmin.dc_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    dc_num VARCHAR(15) NOT NULL,
    balance_amt NUMERIC(18, 0),
    eval_amt NUMERIC(18, 0) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT dc_base_pk PRIMARY KEY (member_id, org_cd, dc_num)
);
;
CREATE TABLE mydataadmin.dc_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    dc_num VARCHAR(15) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    trans_type VARCHAR(2) NOT NULL,
    trans_amt NUMERIC(18, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT dc_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        dc_num,
        trans_dtime
    )
);
;
CREATE TABLE mydataadmin.elec_acc (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    sub_key VARCHAR(64) NOT NULL,
    account_id VARCHAR(180) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    reg_date VARCHAR(8) NOT NULL,
    is_pay VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT elec_acc_pk PRIMARY KEY (
        member_id,
        org_cd,
        sub_key,
        account_id
    )
);
;
CREATE TABLE mydataadmin.elec_pay_method (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    sub_key VARCHAR(64) NOT NULL,
    pay_org_code VARCHAR(8),
    pay_type VARCHAR(2),
    pay_id VARCHAR(180),
    is_primary VARCHAR(1),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT elec_pay_method_pk PRIMARY KEY (
        member_id,
        org_cd,
        sub_key,
        pay_org_code
    )
);
;
CREATE TABLE mydataadmin.elec_ppay (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    fob_id VARCHAR(64) NOT NULL,
    fob_name VARCHAR(225) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    reg_date VARCHAR(8) NOT NULL,
    limit_amt NUMERIC(5, 0) NOT NULL,
    is_charge VARCHAR(1) NOT NULL,
    is_withdrawable VARCHAR(1) NOT NULL,
    currency_code NUMERIC(3, 0),
    account_cnt NUMERIC(3, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT elec_ppay_pk PRIMARY KEY (member_id, org_cd, fob_id)
);
;
CREATE TABLE mydataadmin.elec_ppay_acc (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    fob_id VARCHAR(64) NOT NULL,
    account_id VARCHAR(180),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT elec_ppay_acc_pk PRIMARY KEY (
        member_id,
        org_cd,
        fob_id,
        account_id
    )
);
;
CREATE TABLE mydataadmin.elec_ppay_auto_charge (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    fob_id VARCHAR(64) NOT NULL,
    account_id VARCHAR(180) NOT NULL,
    auto_charge_seq NUMERIC(3, 0) NOT NULL,
    charge_org_code VARCHAR(8),
    charge_account_num VARCHAR(180),
    charge_option VARCHAR(2) NOT NULL,
    charge_day VARCHAR(2),
    charge_base_amt NUMERIC(18, 0),
    charge_amt NUMERIC(18, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT elec_ppay_auto_charge_pk PRIMARY KEY (
        member_id,
        org_cd,
        fob_id,
        account_id,
        auto_charge_seq,
        charge_org_code
    )
);
;
CREATE TABLE mydataadmin.elec_ppay_bal (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    fob_id VARCHAR(64) NOT NULL,
    account_id VARCHAR(180) NOT NULL,
    total_balance_amt NUMERIC(18, 0) NOT NULL,
    charge_balance_amt NUMERIC(18, 0),
    reserve_balance_amt NUMERIC(18, 0),
    withdrawable_amt NUMERIC(18, 0),
    reserve_due_amt NUMERIC(18, 0),
    exp_due_amt NUMERIC(18, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT elec_ppay_bal_pk PRIMARY KEY (
        member_id,
        org_cd,
        fob_id,
        account_id
    )
);
;
CREATE TABLE mydataadmin.elec_ppay_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    fob_id VARCHAR(64) NOT NULL,
    account_id VARCHAR(180) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    trans_type VARCHAR(4) NOT NULL,
    trans_amt NUMERIC(18, 0) NOT NULL,
    balance_amt NUMERIC(18, 0),
    trans_org_code VARCHAR(8),
    trans_id VARCHAR(180),
    trans_num VARCHAR(128),
    trans_memo VARCHAR(90),
    merchant_name VARCHAR(225),
    merchant_regno VARCHAR(12),
    trans_title VARCHAR(900),
    trans_category VARCHAR(2),
    pay_method VARCHAR(2),
    is_scheduled VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT elec_ppay_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        fob_id,
        account_id,
        trans_dtime,
        trans_no,
        trans_type
    )
);
;
CREATE TABLE mydataadmin.gurt (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    prod_name VARCHAR(900) NOT NULL,
    insu_type VARCHAR(2) NOT NULL,
    insu_status VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT gurt_pk PRIMARY KEY (member_id, org_cd, insu_num)
);
;
CREATE TABLE mydataadmin.gurt_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    exp_date VARCHAR(8) NOT NULL,
    face_amt NUMERIC(18, 3) NOT NULL,
    pay_due VARCHAR(2) NOT NULL,
    pay_amt NUMERIC(15, 0) NOT NULL,
    insured_cnt NUMERIC(2, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT gurt_base_pk PRIMARY KEY (member_id, org_cd, insu_num)
);
;
CREATE TABLE mydataadmin.gurt_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    paid_in_cnt NUMERIC(3, 0) NOT NULL,
    trans_date VARCHAR(8) NOT NULL,
    paid_amt NUMERIC(15, 0) NOT NULL,
    pay_method VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT gurt_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        paid_in_cnt,
        trans_date
    )
);
;
CREATE TABLE mydataadmin.gurt_insd (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    insured_name VARCHAR(90) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT gurt_insd_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        insured_name
    )
);
;
CREATE TABLE mydataadmin.insu (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    prod_name VARCHAR(300) NOT NULL,
    insu_type VARCHAR(2) NOT NULL,
    insu_status VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_pk PRIMARY KEY (member_id, org_cd, insu_num)
);
;
CREATE TABLE mydataadmin.insu_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    is_renewable VARCHAR(1) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    exp_date VARCHAR(8) NOT NULL,
    face_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    is_variable VARCHAR(1) NOT NULL,
    is_universal VARCHAR(1) NOT NULL,
    pension_rcv_start_date VARCHAR(8),
    pension_rcv_cycle VARCHAR(2),
    is_loanable VARCHAR(1) NOT NULL,
    insured_cnt NUMERIC(2, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_base_pk PRIMARY KEY (member_id, org_cd, insu_num)
);
;
CREATE TABLE mydataadmin.insu_base_insd (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    insured_no VARCHAR(10) NOT NULL,
    insured_name VARCHAR(30) NOT NULL,
    is_primary VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_base_insd_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        insured_no
    )
);
;
CREATE TABLE mydataadmin.insu_car (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    car_numeric VARCHAR(180),
    car_insu_type VARCHAR(2) NOT NULL,
    car_name VARCHAR(180),
    start_date VARCHAR(8) NOT NULL,
    end_date VARCHAR(8) NOT NULL,
    contract_age VARCHAR(180),
    contract_driver VARCHAR(180),
    is_own_dmg_coverage VARCHAR(1) NOT NULL,
    self_pay_rate VARCHAR(2),
    self_pay_amt NUMERIC(15, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_car_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        car_numeric,
        car_insu_type
    )
);
;
CREATE TABLE mydataadmin.insu_car_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    car_numeric VARCHAR(180) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    face_amt NUMERIC(15, 0) NOT NULL,
    paid_in_cnt NUMERIC(3, 0) NOT NULL,
    paid_amt NUMERIC(15, 0) NOT NULL,
    pay_method VARCHAR(2) NOT NULL,
    pay_org_code VARCHAR(8),
    pay_account_num VARCHAR(20),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_car_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        car_numeric,
        trans_dtime,
        trans_no
    )
);
;
CREATE TABLE mydataadmin.insu_gurt (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    subject VARCHAR(1) NOT NULL,
    relation VARCHAR(2),
    status VARCHAR(1) NOT NULL,
    coverage_code VARCHAR(5) NOT NULL,
    type NUMERIC(1, 0),
    coverage_num VARCHAR(20) NOT NULL,
    coverage_name VARCHAR(900),
    coverage_amt NUMERIC(10, 0) NOT NULL,
    start_date VARCHAR(8),
    end_date VARCHAR(8),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_gurt_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        subject,
        relation
    )
);
;
CREATE TABLE mydataadmin.insu_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    trans_date VARCHAR(8) NOT NULL,
    trans_applied_month NUMERIC(2, 0) NOT NULL,
    paid_in_cnt NUMERIC(3, 0) NOT NULL,
    paid_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    pay_method VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        trans_date,
        trans_applied_month,
        paid_in_cnt
    )
);
;
CREATE TABLE mydataadmin.insu_insd (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    prod_name VARCHAR(900) NOT NULL,
    insu_type VARCHAR(2) NOT NULL,
    insu_status VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_insd_pk PRIMARY KEY (member_id, org_cd, insu_num)
);
;
CREATE TABLE mydataadmin.insu_insd_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    is_renewable VARCHAR(1) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    exp_date VARCHAR(8) NOT NULL,
    face_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    is_variable VARCHAR(1) NOT NULL,
    is_universal VARCHAR(1) NOT NULL,
    issuer_name VARCHAR(90) NOT NULL,
    is_primary VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_insd_base_pk PRIMARY KEY (member_id, org_cd, insu_num)
);
;
CREATE TABLE mydataadmin.insu_insd_car (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    car_numeric VARCHAR(180),
    car_insu_type VARCHAR(2) NOT NULL,
    car_name VARCHAR(180),
    start_date VARCHAR(8) NOT NULL,
    end_date VARCHAR(8) NOT NULL,
    contract_age VARCHAR(180),
    contract_driver VARCHAR(180),
    is_own_dmg_coverage VARCHAR(1) NOT NULL,
    self_pay_rate VARCHAR(2),
    self_pay_amt NUMERIC(15, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_insd_car_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        car_numeric,
        car_insu_type
    )
);
;
CREATE TABLE mydataadmin.insu_insd_gurt (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    gurt_seq NUMERIC(3, 0) NOT NULL,
    subject VARCHAR(1) NOT NULL,
    relation VARCHAR(2),
    status VARCHAR(1) NOT NULL,
    coverage_code VARCHAR(5) NOT NULL,
    type VARCHAR(1) NOT NULL,
    coverage_num VARCHAR(20) NOT NULL,
    coverage_name VARCHAR(900) NOT NULL,
    coverage_amt NUMERIC(10, 0) NOT NULL,
    start_date VARCHAR(8),
    end_date VARCHAR(8),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_insd_gurt_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        gurt_seq,
        subject,
        relation
    )
);
;
CREATE TABLE mydataadmin.insu_insd_mi (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    gurt_seq NUMERIC(3, 0),
    subject VARCHAR(1) NOT NULL,
    relation VARCHAR(2),
    status VARCHAR(2) NOT NULL,
    coverage_code VARCHAR(5) NOT NULL,
    type VARCHAR(1) NOT NULL,
    coverage_num VARCHAR(20) NOT NULL,
    coverage_name VARCHAR(900) NOT NULL,
    coverage_amt NUMERIC(10, 0) NOT NULL,
    start_date VARCHAR(8),
    end_date VARCHAR(8),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_insd_mi_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        gurt_seq,
        subject,
        relation
    )
);
;
CREATE TABLE mydataadmin.insu_insd_mi_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    is_renewable VARCHAR(1) NOT NULL,
    issue_date NUMERIC(8, 0) NOT NULL,
    exp_date NUMERIC(8, 0) NOT NULL,
    face_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3) NOT NULL,
    contractor_name VARCHAR(90) NOT NULL,
    prize_cnt NUMERIC(2, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_insd_mi_base_pk PRIMARY KEY (member_id, org_cd, insu_num)
);
;
CREATE TABLE mydataadmin.insu_insd_mi_base_pp (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    prize_num VARCHAR(15) NOT NULL,
    is_person VARCHAR(2) NOT NULL,
    prize_name VARCHAR(900) NOT NULL,
    is_primary VARCHAR(1),
    prize_addr VARCHAR(900),
    object_code VARCHAR(2),
    prize_code VARCHAR(2),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_insd_mi_base_pp_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        prize_num
    )
);
;
CREATE TABLE mydataadmin.insu_insd_mi_sccont (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    insured_no VARCHAR(20) NOT NULL,
    contract_name VARCHAR(300) NOT NULL,
    contract_status VARCHAR(2) NOT NULL,
    contract_exp_date VARCHAR(8) NOT NULL,
    contract_face_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    is_required VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_insd_mi_sccont_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        insured_no,
        contract_name
    )
);
;
CREATE TABLE mydataadmin.insu_insd_sccont (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    contract_name VARCHAR(900) NOT NULL,
    contract_status VARCHAR(2) NOT NULL,
    contract_exp_date VARCHAR(8) NOT NULL,
    contract_face_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    is_required VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_insd_sccont_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        contract_name
    )
);
;
CREATE TABLE mydataadmin.insu_loan (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    prod_name VARCHAR(900) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    account_type VARCHAR(4) NOT NULL,
    account_status VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_loan_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.insu_loan_add (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    currency_code VARCHAR(3),
    balance_amt NUMERIC(18, 0) NOT NULL,
    loan_principal NUMERIC(18, 0) NOT NULL,
    next_repay_date VARCHAR(8) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_loan_add_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.insu_loan_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    loan_start_date VARCHAR(8) NOT NULL,
    loan_exp_date VARCHAR(8) NOT NULL,
    repay_method VARCHAR(2) NOT NULL,
    insu_num VARCHAR(20),
    repay_org_code VARCHAR(8),
    repay_account_num VARCHAR(20),
    repay_date VARCHAR(2),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_loan_base_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.insu_loan_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    trans_no VARCHAR(20),
    trans_dtime VARCHAR(14) NOT NULL,
    currency_code VARCHAR(3),
    loan_paid_amt NUMERIC(18, 0) NOT NULL,
    int_paid_amt NUMERIC(18, 0) NOT NULL,
    int_cnt NUMERIC(3, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_loan_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.insu_loan_hist_int (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    trans_no VARCHAR(20),
    trans_dtime VARCHAR(14) NOT NULL,
    int_start_date VARCHAR(8),
    int_end_date VARCHAR(8),
    int_rate NUMERIC(5, 0),
    int_type VARCHAR(2),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_loan_hist_int_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.insu_mi (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    subject VARCHAR(1) NOT NULL,
    relation VARCHAR(2),
    status VARCHAR(2) NOT NULL,
    coverage_code VARCHAR(5) NOT NULL,
    type VARCHAR(1) NOT NULL,
    coverage_num VARCHAR(20) NOT NULL,
    coverage_name VARCHAR(900) NOT NULL,
    coverage_amt NUMERIC(10, 0) NOT NULL,
    start_date VARCHAR(8),
    end_date VARCHAR(8),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_mi_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        subject,
        relation
    )
);
;
CREATE TABLE mydataadmin.insu_mi_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    is_renewable VARCHAR(1) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    exp_date VARCHAR(8) NOT NULL,
    face_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3) NOT NULL,
    prize_cnt NUMERIC(2, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_mi_base_pk PRIMARY KEY (member_id, org_cd, insu_num)
);
;
CREATE TABLE mydataadmin.insu_mi_base_pp (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    is_person VARCHAR(2) NOT NULL,
    prize_num VARCHAR(15) NOT NULL,
    prize_name VARCHAR(900) NOT NULL,
    is_primary VARCHAR(1),
    prize_addr VARCHAR(900),
    object_code VARCHAR(2),
    prize_code VARCHAR(2),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_mi_base_pp_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        is_person,
        prize_num
    )
);
;
CREATE TABLE mydataadmin.insu_mi_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    trans_date VARCHAR(8) NOT NULL,
    trans_applied_month NUMERIC(6, 0) NOT NULL,
    paid_in_cnt NUMERIC(3, 0) NOT NULL,
    paid_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    pay_method VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_mi_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        trans_date,
        trans_applied_month,
        paid_in_cnt
    )
);
;
CREATE TABLE mydataadmin.insu_mi_pay (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    pay_due VARCHAR(2) NOT NULL,
    pay_cycle VARCHAR(2) NOT NULL,
    pay_cnt NUMERIC(5, 0) NOT NULL,
    pay_org_code VARCHAR(8),
    pay_account_num VARCHAR(20),
    pay_date VARCHAR(2),
    pay_end_date VARCHAR(8) NOT NULL,
    pay_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    is_auto_pay VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_mi_pay_pk PRIMARY KEY (member_id, org_cd, insu_num)
);
;
CREATE TABLE mydataadmin.insu_mi_sccont (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    prize_num VARCHAR(15) NOT NULL,
    contract_name VARCHAR(900) NOT NULL,
    contract_status VARCHAR(2) NOT NULL,
    contract_exp_date VARCHAR(8) NOT NULL,
    contract_face_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    is_required VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_mi_sccont_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        prize_num,
        contract_name
    )
);
;
CREATE TABLE mydataadmin.insu_pay (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    pay_due VARCHAR(2) NOT NULL,
    pay_cycle VARCHAR(2) NOT NULL,
    pay_cnt NUMERIC(5, 0) NOT NULL,
    pay_org_code VARCHAR(8),
    pay_account_num VARCHAR(20),
    pay_date VARCHAR(2),
    pay_end_date VARCHAR(8) NOT NULL,
    pay_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    is_auto_pay VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_pay_pk PRIMARY KEY (member_id, org_cd, insu_num)
);
;
CREATE TABLE mydataadmin.insu_sccont (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    insu_num VARCHAR(20) NOT NULL,
    insured_no VARCHAR(10) NOT NULL,
    contract_name VARCHAR(900) NOT NULL,
    contract_status VARCHAR(2) NOT NULL,
    contract_exp_date VARCHAR(8) NOT NULL,
    contract_face_amt NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    is_required VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT insu_sccont_pk PRIMARY KEY (
        member_id,
        org_cd,
        insu_num,
        insured_no,
        contract_name
    )
);
;
CREATE TABLE mydataadmin.invt_acc (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    account_name VARCHAR(180) NOT NULL,
    account_type VARCHAR(3) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    is_tax_benefits VARCHAR(1) NOT NULL,
    is_cma VARCHAR(1) NOT NULL,
    is_stock_trans VARCHAR(1) NOT NULL,
    is_account_link VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT invt_acc_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.invt_acc_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    currency_code VARCHAR(3) NOT NULL,
    withholdings_amt NUMERIC(18, 0) NOT NULL,
    credit_loan_amt NUMERIC(18, 0) NOT NULL,
    mortgage_amt NUMERIC(18, 0) NOT NULL,
    avail_balance NUMERIC(18, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT invt_acc_base_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.invt_acc_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    prod_name VARCHAR(180),
    prod_code VARCHAR(12),
    trans_no VARCHAR(64),
    trans_type VARCHAR(3) NOT NULL,
    trans_type_detail VARCHAR(180) NOT NULL,
    trans_num NUMERIC(21, 0),
    trans_unit VARCHAR(90),
    base_amt NUMERIC(17, 0),
    trans_amt NUMERIC(18, 0),
    settle_amt NUMERIC(18, 0),
    balance_amt NUMERIC(18, 0),
    currency_code VARCHAR(3),
    trans_memo VARCHAR(270),
    ex_code VARCHAR(3),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT invt_acc_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        trans_dtime
    )
);
;
CREATE TABLE mydataadmin.invt_acc_prod_base_date (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    base_date VARCHAR(8) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    CONSTRAINT invt_acc_prod_base_date_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.invt_auto_trans (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    scheduled_org_code VARCHAR(8) NOT NULL,
    scheduled_account_num VARCHAR(20) NOT NULL,
    scheduled_amt NUMERIC(18, 0) NOT NULL,
    scheduled_cycle VARCHAR(2) NOT NULL,
    scheduled_date VARCHAR(2),
    trans_memo VARCHAR(270),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT invt_auto_trans_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.invt_pension_acc_add (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    paid_in_amt NUMERIC(18, 0) NOT NULL,
    withdrawal_amt NUMERIC(18, 0) NOT NULL,
    last_paid_in_date VARCHAR(8),
    rcv_amt NUMERIC(18, 0) NOT NULL,
    pension_rcv_start_date VARCHAR(8),
    annual_pay_amount NUMERIC(18, 0) NOT NULL,
    currency_code VARCHAR(3),
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    CONSTRAINT invt_pension_acc_add_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.irp_acc (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    prod_name VARCHAR(900) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT irp_acc_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.irp_acc_add (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    irp_name VARCHAR(900) NOT NULL,
    irp_no VARCHAR(64),
    irp_type VARCHAR(2) NOT NULL,
    eval_amt NUMERIC(18, 0) NOT NULL,
    inv_principal NUMERIC(18, 0) NOT NULL,
    fund_num NUMERIC(18, 0),
    open_date VARCHAR(8),
    exp_date VARCHAR(8),
    int_rate NUMERIC(5, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT irp_acc_add_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        irp_name
    )
);
;
CREATE TABLE mydataadmin.irp_acc_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    accum_amt NUMERIC(18, 0) NOT NULL,
    eval_amt NUMERIC(18, 0) NOT NULL,
    employer_amt NUMERIC(18, 0) NOT NULL,
    employee_amt NUMERIC(18, 0) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    first_deposit_date VARCHAR(8),
    reg_date VARCHAR(8),
    rcv_start_date VARCHAR(8),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT irp_acc_base_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.irp_acc_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    trans_type VARCHAR(2) NOT NULL,
    trans_no VARCHAR(64),
    trans_amt NUMERIC(15, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT irp_acc_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        trans_dtime
    )
);
;
CREATE TABLE mydataadmin.itfn_acc (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    seqno VARCHAR(7),
    prod_name VARCHAR(900) NOT NULL,
    account_type VARCHAR(4) NOT NULL,
    account_status VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT itfn_acc_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num
    )
);
;
CREATE TABLE mydataadmin.itfn_cust (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    reg_date VARCHAR(20) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    CONSTRAINT itfn_cust_pk PRIMARY KEY (member_id, org_cd)
);
;
CREATE TABLE mydataadmin.itfn_lease (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    exp_date VARCHAR(8) NOT NULL,
    repay_date VARCHAR(2) NOT NULL,
    repay_method VARCHAR(2) NOT NULL,
    repay_org_code VARCHAR(8),
    repay_account_num VARCHAR(20),
    next_repay_date VARCHAR(8) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT itfn_lease_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno
    )
);
;
CREATE TABLE mydataadmin.itfn_lease_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    trans_type VARCHAR(2) NOT NULL,
    trans_amt NUMERIC(18, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT itfn_lease_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno
    )
);
;
CREATE TABLE mydataadmin.itfn_loan (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    exp_date VARCHAR(8) NOT NULL,
    last_offered_rate NUMERIC(7, 0) NOT NULL,
    repay_date VARCHAR(2),
    repay_method VARCHAR(2) NOT NULL,
    repay_org_code VARCHAR(8),
    repay_account_num VARCHAR(20),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT itfn_loan_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno
    )
);
;
CREATE TABLE mydataadmin.itfn_loan_add (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7) NOT NULL,
    currency_code VARCHAR(3),
    balance_amt NUMERIC(18, 0) NOT NULL,
    loan_principal NUMERIC(18, 0) NOT NULL,
    next_repay_date VARCHAR(8) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT itfn_loan_add_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno
    )
);
;
CREATE TABLE mydataadmin.itfn_loan_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    trans_type VARCHAR(2) NOT NULL,
    currency_code VARCHAR(3),
    trans_amt NUMERIC(18, 0) NOT NULL,
    balance_amt NUMERIC(18, 0) NOT NULL,
    principal_amt NUMERIC(18, 0) NOT NULL,
    int_amt NUMERIC(18, 0) NOT NULL,
    ret_int_amt NUMERIC(18, 0),
    int_cnt NUMERIC(3, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT itfn_loan_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno,
        trans_dtime,
        trans_no
    )
);
;
CREATE TABLE mydataadmin.itfn_loan_hist_int (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    account_num VARCHAR(20) NOT NULL,
    seqno VARCHAR(7) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    trans_no VARCHAR(64),
    int_start_date VARCHAR(8) NOT NULL,
    int_end_date VARCHAR(8),
    int_rate NUMERIC(5, 0) NOT NULL,
    applied_int_amt NUMERIC(18, 0),
    int_type VARCHAR(2) NOT NULL,
    int_amt NUMERIC(18, 0) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    CONSTRAINT itfn_loan_hist_int_pk PRIMARY KEY (
        member_id,
        org_cd,
        account_num,
        seqno,
        trans_dtime,
        trans_no,
        int_start_date,
        int_end_date
    )
);
;
CREATE TABLE mydataadmin.member (
    member_id VARCHAR(20) NOT NULL,
    ci VARCHAR(100),
    member_rn VARCHAR(20),
    member_pwd VARCHAR(200),
    member_name VARCHAR(20),
    member_status VARCHAR(2),
    join_dt VARCHAR(14),
    leave_dt VARCHAR(14),
    last_contact_dt VARCHAR(14),
    reg_user_id VARCHAR(20),
    reg_dt VARCHAR(14),
    chg_user_id VARCHAR(20),
    chg_dt VARCHAR(14),
    CONSTRAINT member_pk PRIMARY KEY (member_id)
);
;
CREATE TABLE mydataadmin.member_token (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(20) NOT NULL,
    send_req_seq NUMERIC(5, 0) NOT NULL,
    scope_list VARCHAR(128),
    send_request_type VARCHAR(2),
    fp_send_req_yn VARCHAR(1),
    fp_send_req_dt VARCHAR(14),
    fp_send_req_start_day VARCHAR(8),
    fp_send_req_end_day VARCHAR(8),
    fp_cycl VARCHAR(2),
    access_token VARCHAR(1500),
    access_token_expire_in NUMERIC(7, 0),
    access_token_issue_dt VARCHAR(14),
    access_token_due_dt VARCHAR(14),
    access_token_expire_yn VARCHAR(1),
    access_token_expire_dt VARCHAR(14),
    represh_token VARCHAR(1500),
    represh_token_expire_in NUMERIC(7, 0),
    represh_token_issue_dt VARCHAR(14),
    represh_token_due_dt VARCHAR(14),
    represh_token_expire_yn VARCHAR(1),
    represh_token_expire_dt VARCHAR(14),
    reg_user_id VARCHAR(20),
    reg_dt VARCHAR(14),
    chg_user_id VARCHAR(20),
    chg_dt VARCHAR(14),
    idst_type VARCHAR(10),
    CONSTRAINT member_token_pk PRIMARY KEY (
        member_id,
        org_cd,
        send_req_seq
    )
);
;
CREATE TABLE mydataadmin.org_mst (
    org_cd VARCHAR(20) NOT NULL,
    org_type VARCHAR(2) NOT NULL,
    idst_type VARCHAR(10) NOT NULL,
    org_nm VARCHAR(100) NOT NULL,
    org_short_nm VARCHAR(40) NOT NULL,
    org_status VARCHAR(1) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    CONSTRAINT org_mst_pk PRIMARY KEY (org_cd, org_type, idst_type)
);
;
CREATE TABLE mydataadmin.p2p_loan (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    lending_id VARCHAR(15) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    type VARCHAR(2) NOT NULL,
    lending_amt NUMERIC(18, 0) NOT NULL,
    issue_date VARCHAR(8) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT p2p_loan_pk PRIMARY KEY (member_id, org_cd, lending_id)
);
;
CREATE TABLE mydataadmin.p2p_loan_add (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    lending_id VARCHAR(40) NOT NULL,
    balance_amt NUMERIC(15, 0) NOT NULL,
    next_repay_cnt NUMERIC(3, 0) NOT NULL,
    next_repay_date VARCHAR(8) NOT NULL,
    principal_amt NUMERIC(15, 0) NOT NULL,
    int_amt NUMERIC(15, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT p2p_loan_add_pk PRIMARY KEY (member_id, org_cd, lending_id)
);
;
CREATE TABLE mydataadmin.p2p_loan_base (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    lending_id VARCHAR(40) NOT NULL,
    exp_date VARCHAR(8) NOT NULL,
    offered_rate NUMERIC(7, 0) NOT NULL,
    repay_method VARCHAR(2) NOT NULL,
    ltv_rate NUMERIC(3, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT p2p_loan_base_pk PRIMARY KEY (member_id, org_cd, lending_id)
);
;
CREATE TABLE mydataadmin.ppay (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    pp_id VARCHAR(64) NOT NULL,
    pp_name VARCHAR(900) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    reg_date VARCHAR(8) NOT NULL,
    limit_amt NUMERIC(5, 0) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT ppay_pk PRIMARY KEY (member_id, org_cd, pp_id)
);
;
CREATE TABLE mydataadmin.ppay_apr_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    pp_id VARCHAR(64) NOT NULL,
    approved_num VARCHAR(14) NOT NULL,
    approved_dtime VARCHAR(14) NOT NULL,
    status VARCHAR(2) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    merchant_name VARCHAR(225),
    merchant_regno VARCHAR(12),
    approved_amt NUMERIC(15, 0) NOT NULL,
    modified_amt NUMERIC(15, 0),
    total_install_cnt NUMERIC(5, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT ppay_apr_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        pp_id,
        approved_num,
        approved_dtime,
        status,
        trans_dtime
    )
);
;
CREATE TABLE mydataadmin.ppay_bal (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    pp_id VARCHAR(64) NOT NULL,
    total_balance_amt VARCHAR(900) NOT NULL,
    charge_balance_amt NUMERIC(18, 0),
    reserve_balance_amt NUMERIC(18, 0),
    reserve_due_amt NUMERIC(18, 0),
    exp_due_amt NUMERIC(18, 0),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT ppay_bal_pk PRIMARY KEY (member_id, org_cd, pp_id)
);
;
CREATE TABLE mydataadmin.ppay_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    pp_id VARCHAR(64) NOT NULL,
    trans_dtime VARCHAR(14) NOT NULL,
    trans_type VARCHAR(4) NOT NULL,
    trans_no VARCHAR(64),
    trans_amt NUMERIC(18, 0) NOT NULL,
    balance_amt NUMERIC(18, 0),
    trans_org_code VARCHAR(8),
    trans_id VARCHAR(180),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT ppay_hist_pk PRIMARY KEY (
        member_id,
        org_cd,
        pp_id,
        trans_dtime,
        trans_type
    )
);
;
CREATE TABLE mydataadmin.recv_baseline (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(20) NOT NULL,
    api_id VARCHAR(10) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    search_time_stamp NUMERIC(14, 0),
    next_page VARCHAR(1000),
    last_recv_dt VARCHAR(14),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    CONSTRAINT recv_baseline_pk PRIMARY KEY (
        member_id,
        org_cd,
        api_id,
        api_tran_day,
        api_tran_id
    )
);
;
CREATE TABLE mydataadmin.recv_hist_base (
    recv_seq VARCHAR(25) NOT NULL,
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(20) NOT NULL,
    api_id VARCHAR(10) NOT NULL,
    recv_start_dt VARCHAR(14),
    recv_end_dt VARCHAR(14),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    CONSTRAINT recv_hist_base_pk PRIMARY KEY (
        recv_seq,
        member_id,
        org_cd,
        api_id
    )
);
;
CREATE INDEX recv_hist_base_member_id_idx ON mydataadmin.recv_hist_base (
    member_id,
    org_cd,
    api_id,
    recv_start_dt
);

CREATE TABLE mydataadmin.recv_hist_detail (
    recv_seq VARCHAR(25) NOT NULL,
    recv_detail_seq NUMERIC(10, 0) NOT NULL,
    recv_data VARCHAR(3000) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    CONSTRAINT recv_hist_detail_pk PRIMARY KEY (recv_seq, recv_detail_seq)
);
;
CREATE TABLE mydataadmin.recv_status (
    member_id VARCHAR(20) NOT NULL,
    recv_day VARCHAR(8) NOT NULL,
    recv_seq VARCHAR(25),
    target_org_cnt NUMERIC(3, 0),
    complete_org_cnt NUMERIC(3, 0),
    recv_status VARCHAR(1),
    recv_start_dt VARCHAR(14),
    recv_end_dt VARCHAR(14),
    last_recv_org_cd VARCHAR(20),
    last_recv_dt VARCHAR(14),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    CONSTRAINT recv_status_pk PRIMARY KEY (member_id, recv_day, recv_seq)
);
;
CREATE TABLE mydataadmin.tele_charge (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    mgmt_id VARCHAR(15) NOT NULL,
    charge_month VARCHAR(6) NOT NULL,
    charge_amt NUMERIC(15, 0) NOT NULL,
    charge_date VARCHAR(8) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT tele_charge_pk PRIMARY KEY (member_id, org_cd, mgmt_id)
);
;
CREATE TABLE mydataadmin.tele_cont (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    mgmt_id VARCHAR(15) NOT NULL,
    is_consent VARCHAR(1) NOT NULL,
    telecom_num VARCHAR(15) NOT NULL,
    type VARCHAR(2) NOT NULL,
    status VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT tele_cont_pk PRIMARY KEY (member_id, org_cd, mgmt_id)
);
;
CREATE TABLE mydataadmin.tele_hist (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    mgmt_id VARCHAR(15) NOT NULL,
    trans_month VARCHAR(6) NOT NULL,
    paid_amt NUMERIC(15, 0) NOT NULL,
    pay_method VARCHAR(2) NOT NULL,
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT tele_hist_pk PRIMARY KEY (member_id, org_cd, mgmt_id)
);
;
CREATE TABLE mydataadmin.tele_pay (
    member_id VARCHAR(20) NOT NULL,
    org_cd VARCHAR(10) NOT NULL,
    mgmt_id VARCHAR(15) NOT NULL,
    trans_date VARCHAR(14) NOT NULL,
    trans_amt NUMERIC(15, 0) NOT NULL,
    org_regno VARCHAR(12),
    merchant_name VARCHAR(225),
    trans_title VARCHAR(900),
    reg_user_id VARCHAR(20) NOT NULL,
    reg_dt VARCHAR(14) NOT NULL,
    chg_user_id VARCHAR(20) NOT NULL,
    chg_dt VARCHAR(14) NOT NULL,
    api_tran_day VARCHAR(8) NOT NULL,
    api_tran_id VARCHAR(25) NOT NULL,
    CONSTRAINT tele_pay_pk PRIMARY KEY (member_id, org_cd, mgmt_id)
);
;