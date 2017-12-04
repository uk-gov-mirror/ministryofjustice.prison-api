--Wings AG1
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, USER_DESC) VALUES (-11, 'A', 'WING', 'AG1', 'AG1-A', null, 'House Block A');
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, USER_DESC) VALUES (-12, 'B', 'WING', 'AG1', 'AG1-B', null, 'House Block B');
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, USER_DESC) VALUES (-13, 'C', 'WING', 'AG1', 'AG1-C', null, 'House Block C');

--Wings AG2
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, USER_DESC) VALUES (-21, 'A', 'WING', 'AG2', 'AG2-A', null, 'Unit A');
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, USER_DESC) VALUES (-22, 'B', 'WING', 'AG2', 'AG2-B', null, 'Unit B');

--Wings AG3
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, USER_DESC) VALUES (-31, 'A', 'WING', 'AG3', 'AG3-A', null, 'Block A');
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, USER_DESC) VALUES (-32, 'B', 'WING', 'AG3', 'AG3-B', null, 'Block B');

--Wings AG4
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, USER_DESC) VALUES (-41, 'A', 'WING', 'AG4', 'AG4-A', null, 'Wing A');
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, USER_DESC) VALUES (-42, 'B', 'WING', 'AG4', 'AG4-B', null, 'Wing B');

--Wings AG5
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, USER_DESC) VALUES (-51, 'A', 'WING', 'AG5', 'AG5-A', null, 'Main Building');

-- Landings for all each agency, there are 2 landings for each wing except in AG1 where there are 3 landings

-- Landings AG1
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-111, '1', 'LAND', 'AG1', 'AG1-A-1', -11, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-112, '2', 'LAND', 'AG1', 'AG1-A-2', -11, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-121, '1', 'LAND', 'AG1', 'AG1-B-1', -12, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-122, '2', 'LAND', 'AG1', 'AG1-B-2', -12, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-131, '1', 'LAND', 'AG1', 'AG1-C-1', -13, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-132, '2', 'LAND', 'AG1', 'AG1-C-2', -13, 0);


-- Landings AG2
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-211, '1', 'LAND', 'AG2', 'AG2-A-1', -21, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-212, '2', 'LAND', 'AG2', 'AG2-A-2', -21, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-221, '1', 'LAND', 'AG2', 'AG2-B-1', -22, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-222, '2', 'LAND', 'AG2', 'AG2-B-2', -22, 0);


-- Landings AG3
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-311, '1', 'LAND', 'AG3', 'AG3-A-1', -31, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-312, '2', 'LAND', 'AG3', 'AG3-A-2', -31, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-321, '1', 'LAND', 'AG3', 'AG3-B-1', -32, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-322, '2', 'LAND', 'AG3', 'AG3-B-2', -32, 0);


-- Landings AG4
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-411, '1', 'LAND', 'AG4', 'AG4-A-1', -41, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-412, '2', 'LAND', 'AG4', 'AG4-A-2', -41, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-421, '1', 'LAND', 'AG4', 'AG4-B-1', -42, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-422, '2', 'LAND', 'AG4', 'AG4-B-2', -42, 0);


-- Landings AG5
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-511, '1', 'LAND', 'AG5', 'AG5-A-1', -51, 0);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-512, '2', 'LAND', 'AG5', 'AG5-A-2', -51, 0);

--
-- Cells for each agency, 5 Cells per landing.
--

INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-111001, '001', 'CELL', 'AG1', 'AG1-A-1-1', -111, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-111002, '002', 'CELL', 'AG1', 'AG1-A-1-2', -111, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-111003, '003', 'CELL', 'AG1', 'AG1-A-1-3', -111, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-111004, '004', 'CELL', 'AG1', 'AG1-A-1-4', -111, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-111005, '005', 'CELL', 'AG1', 'AG1-A-1-5', -111, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-112001, '001', 'CELL', 'AG1', 'AG1-A-2-1', -112, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-112002, '002', 'CELL', 'AG1', 'AG1-A-2-2', -112, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-112003, '003', 'CELL', 'AG1', 'AG1-A-2-3', -112, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-112004, '004', 'CELL', 'AG1', 'AG1-A-2-4', -112, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-112005, '005', 'CELL', 'AG1', 'AG1-A-2-5', -112, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-121001, '001', 'CELL', 'AG1', 'AG1-B-1-1', -121, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-121002, '002', 'CELL', 'AG1', 'AG1-B-1-2', -121, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-121003, '003', 'CELL', 'AG1', 'AG1-B-1-3', -121, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-121004, '004', 'CELL', 'AG1', 'AG1-B-1-4', -121, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-121005, '005', 'CELL', 'AG1', 'AG1-B-1-5', -121, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-122001, '001', 'CELL', 'AG1', 'AG1-B-2-1', -122, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-122002, '002', 'CELL', 'AG1', 'AG1-B-2-2', -122, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-122003, '003', 'CELL', 'AG1', 'AG1-B-2-3', -122, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-122004, '004', 'CELL', 'AG1', 'AG1-B-2-4', -122, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-122005, '005', 'CELL', 'AG1', 'AG1-B-2-5', -122, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-131001, '001', 'CELL', 'AG1', 'AG1-C-1-1', -131, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-131002, '002', 'CELL', 'AG1', 'AG1-C-1-2', -131, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-131003, '003', 'CELL', 'AG1', 'AG1-C-1-3', -131, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-131004, '004', 'CELL', 'AG1', 'AG1-C-1-4', -131, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-131005, '005', 'CELL', 'AG1', 'AG1-C-1-5', -131, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-132001, '001', 'CELL', 'AG1', 'AG1-C-2-1', -132, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-132002, '002', 'CELL', 'AG1', 'AG1-C-2-2', -132, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-132003, '003', 'CELL', 'AG1', 'AG1-C-2-3', -132, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-132004, '004', 'CELL', 'AG1', 'AG1-C-2-4', -132, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-132005, '005', 'CELL', 'AG1', 'AG1-C-2-5', -132, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-211001, '001', 'CELL', 'AG2', 'AG2-A-1-1', -211, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-211002, '002', 'CELL', 'AG2', 'AG2-A-1-2', -211, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-211003, '003', 'CELL', 'AG2', 'AG2-A-1-3', -211, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-211004, '004', 'CELL', 'AG2', 'AG2-A-1-4', -211, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-211005, '005', 'CELL', 'AG2', 'AG2-A-1-5', -211, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-212001, '001', 'CELL', 'AG2', 'AG2-A-2-1', -212, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-212002, '002', 'CELL', 'AG2', 'AG2-A-2-2', -212, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-212003, '003', 'CELL', 'AG2', 'AG2-A-2-3', -212, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-212004, '004', 'CELL', 'AG2', 'AG2-A-2-4', -212, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-212005, '005', 'CELL', 'AG2', 'AG2-A-2-5', -212, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-221001, '001', 'CELL', 'AG2', 'AG2-B-1-1', -221, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-221002, '002', 'CELL', 'AG2', 'AG2-B-1-2', -221, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-221003, '003', 'CELL', 'AG2', 'AG2-B-1-3', -221, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-221004, '004', 'CELL', 'AG2', 'AG2-B-1-4', -221, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-221005, '005', 'CELL', 'AG2', 'AG2-B-1-5', -221, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-222001, '001', 'CELL', 'AG2', 'AG2-B-2-1', -222, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-222002, '002', 'CELL', 'AG2', 'AG2-B-2-2', -222, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-222003, '003', 'CELL', 'AG2', 'AG2-B-2-3', -222, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-222004, '004', 'CELL', 'AG2', 'AG2-B-2-4', -222, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-222005, '005', 'CELL', 'AG2', 'AG2-B-2-5', -222, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-311001, '001', 'CELL', 'AG3', 'AG3-A-1-1', -311, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-311002, '002', 'CELL', 'AG3', 'AG3-A-1-2', -311, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-311003, '003', 'CELL', 'AG3', 'AG3-A-1-3', -311, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-311004, '004', 'CELL', 'AG3', 'AG3-A-1-4', -311, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-311005, '005', 'CELL', 'AG3', 'AG3-A-1-5', -311, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-312001, '001', 'CELL', 'AG3', 'AG3-A-2-1', -312, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-312002, '002', 'CELL', 'AG3', 'AG3-A-2-2', -312, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-312003, '003', 'CELL', 'AG3', 'AG3-A-2-3', -312, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-312004, '004', 'CELL', 'AG3', 'AG3-A-2-4', -312, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-312005, '005', 'CELL', 'AG3', 'AG3-A-2-5', -312, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-321001, '001', 'CELL', 'AG3', 'AG3-B-1-1', -321, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-321002, '002', 'CELL', 'AG3', 'AG3-B-1-2', -321, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-321003, '003', 'CELL', 'AG3', 'AG3-B-1-3', -321, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-321004, '004', 'CELL', 'AG3', 'AG3-B-1-4', -321, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-321005, '005', 'CELL', 'AG3', 'AG3-B-1-5', -321, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-322001, '001', 'CELL', 'AG3', 'AG3-B-2-1', -322, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-322002, '002', 'CELL', 'AG3', 'AG3-B-2-2', -322, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-322003, '003', 'CELL', 'AG3', 'AG3-B-2-3', -322, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-322004, '004', 'CELL', 'AG3', 'AG3-B-2-4', -322, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-322005, '005', 'CELL', 'AG3', 'AG3-B-2-5', -322, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-411001, '001', 'CELL', 'AG4', 'AG4-A-1-1', -411, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-411002, '002', 'CELL', 'AG4', 'AG4-A-1-2', -411, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-411003, '003', 'CELL', 'AG4', 'AG4-A-1-3', -411, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-411004, '004', 'CELL', 'AG4', 'AG4-A-1-4', -411, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-411005, '005', 'CELL', 'AG4', 'AG4-A-1-5', -411, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-412001, '001', 'CELL', 'AG4', 'AG4-A-2-1', -412, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-412002, '002', 'CELL', 'AG4', 'AG4-A-2-2', -412, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-412003, '003', 'CELL', 'AG4', 'AG4-A-2-3', -412, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-412004, '004', 'CELL', 'AG4', 'AG4-A-2-4', -412, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-412005, '005', 'CELL', 'AG4', 'AG4-A-2-5', -412, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-421001, '001', 'CELL', 'AG4', 'AG4-B-1-1', -421, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-421002, '002', 'CELL', 'AG4', 'AG4-B-1-2', -421, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-421003, '003', 'CELL', 'AG4', 'AG4-B-1-3', -421, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-421004, '004', 'CELL', 'AG4', 'AG4-B-1-4', -421, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-421005, '005', 'CELL', 'AG4', 'AG4-B-1-5', -421, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-422001, '001', 'CELL', 'AG4', 'AG4-B-2-1', -422, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-422002, '002', 'CELL', 'AG4', 'AG4-B-2-2', -422, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-422003, '003', 'CELL', 'AG4', 'AG4-B-2-3', -422, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-422004, '004', 'CELL', 'AG4', 'AG4-B-2-4', -422, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-422005, '005', 'CELL', 'AG4', 'AG4-B-2-5', -422, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-511001, '001', 'CELL', 'AG5', 'AG5-A-1-1', -511, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-511002, '002', 'CELL', 'AG5', 'AG5-A-1-2', -511, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-511003, '003', 'CELL', 'AG5', 'AG5-A-1-3', -511, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-511004, '004', 'CELL', 'AG5', 'AG5-A-1-4', -511, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-511005, '005', 'CELL', 'AG5', 'AG5-A-1-5', -511, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-512001, '001', 'CELL', 'AG5', 'AG5-A-2-1', -512, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-512002, '002', 'CELL', 'AG5', 'AG5-A-2-2', -512, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-512003, '003', 'CELL', 'AG5', 'AG5-A-2-3', -512, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-512004, '004', 'CELL', 'AG5', 'AG5-A-2-4', -512, 1);
INSERT INTO AGENCY_INTERNAL_LOCATIONS (INTERNAL_LOCATION_ID, INTERNAL_LOCATION_CODE, INTERNAL_LOCATION_TYPE, AGY_LOC_ID, DESCRIPTION, PARENT_INTERNAL_LOCATION_ID, NO_OF_OCCUPANT) VALUES (-512005, '005', 'CELL', 'AG5', 'AG5-A-2-5', -512, 1);