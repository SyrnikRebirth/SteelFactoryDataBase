create table Workers
(
  pass_id           int primary key,
  shift_no          int,
  full_name         VARCHAR(90) NOT NULL,
  position          VARCHAR(30) not null,
  date_of_emplyment TIMESTAMP(0)
);

create table Shifts
(
  shift_no        int primary key,
  workshop_no     int,
  type_of_product VARCHAR(30),
  start_time      TIMESTAMP(0) not null,
  end_time        TIMESTAMP(0) not null
);

create table Products_per_day_by_shift
(
  date                          timestamp(0),
  shift_no                      int,
  number_of_produced_production int not null,
  primary key (date, shift_no)
);

create table Workshops
(
  workshop_no         int primary key,
  date_of_last_update timestamp(0),
  scrap_rate          real,
  production_rate     int not null
);

create table Machines
(
  workshop_no     int,
  machine_type    VARCHAR(30) not null,
  type_of_product VARCHAR(30)
);

create table Production
(
  type_of_product VARCHAR(30) primary key
);

create table Production_value
(
  type_of_product  VARCHAR(30),
  date_value_start TIMESTAMP(0) NOT NULL,
  date_value_end   TIMESTAMP(0) NOT NULL,
  value            INT          NOT NULL,
  primary key (type_of_product, date_value_end, date_value_start)
);

create table Required_materials
(
  type_of_product   VARCHAR(30),
  type_of_materials VARCHAR(30)
);

create table Material
(
  type_of_materials VARCHAR(30) primary key
);

create table Materials_cost
(
  type_of_materials VARCHAR(30),
  date_cost_start   TIMESTAMP(0) NOT NULL,
  date_cost_end     TIMESTAMP(0) NOT NULL,
  cost              INT          NOT NULL,
  primary key (date_cost_start, date_cost_end)
);

alter table Workers
  add constraint FK_ShiftWoker foreign key (shift_no) references Shifts (shift_no);
alter table Shifts
  add constraint FK_ShiftWokshop foreign key (workshop_no) references Workshops (workshop_no);
alter table Shifts
  add constraint FK_ShiftProduction foreign key (type_of_product) references Production (type_of_product);
alter table Machines
  add constraint FK_MachinesWokshop foreign key (workshop_no) references Workshops (workshop_no);
alter table Machines
  add constraint FK_MachinesProduction foreign key (type_of_product) references Production (type_of_product);
alter table Products_per_day_by_shift
  add constraint FK_ProductionPerDayShifts foreign key (shift_no) references Shifts (shift_no);
alter table Production_value
  add constraint FK_ProductionProduction_value foreign key (type_of_product) references Production (type_of_product);
alter table Required_materials
  add constraint FK_ProductionRequired_materials foreign key (type_of_product) references Production (type_of_product);
alter table Required_materials
  add constraint FK_MaterialsPerDayShifts foreign key (type_of_materials) references Material (type_of_materials);
alter table Materials_cost
  add constraint FK_MaterialsMaterials_cost foreign key (type_of_materials) references Material (type_of_materials);

insert into Workshops (workshop_no, date_of_last_update, scrap_rate, production_rate)
values (1, '1990-06-12', 0.24, 230),
       (2, '1983-07-18', 0.29, 230),
       (3, '1965-12-23', 0.36, 230),
       (4, '2003-05-30', 0.14, 95),
       (5, '2005-03-07', 0.15, 95);

insert into Production (type_of_product)
values ('steel 15XCHD'),
       ('steel P5'),
       ('steel SHX4'),
       ('durasteel 9DOG5'),
       ('durasteel K9');

insert into Machines (workshop_no, machine_type, type_of_product)
VALUES (1, 'melting furnace', 'steel 15XCHD'),
       (2, 'melting furnace', 'steel P5'),
       (3, 'melting furnace', 'steel SHX4'),
       (4, 'industrial furnace', 'durasteel 9DOG5'),
       (5, 'industrial furnace', 'durasteel K9');

insert into Shifts (shift_no, workshop_no, type_of_product, start_time, end_time)
values (1, 2, 'steel P5', '4000-01-01 07:00:00', '4000-01-01 15:00:00'),
       (2, 2, 'steel P5', '4000-01-01 15:00:00', '4000-01-01 23:00:00'),
       (3, 1, 'steel 15XCHD', '4000-01-01 07:00:00', '4000-01-01 15:00:00'),
       (4, 1, 'steel 15XCHD', '4000-01-01 15:00:00', '4000-01-01 23:00:00'),
       (5, 3, 'steel SHX4', '4000-01-01 07:00:00', '4000-01-01 15:00:00'),
       (6, 3, 'steel SHX4', '4000-01-01 15:00:00', '4000-01-01 23:00:00'),
       (7, 4, 'durasteel 9DOG5', '4000-01-01 07:00:00', '4000-01-01 15:00:00'),
       (8, 4, 'durasteel 9DOG5', '4000-01-01 15:00:00', '4000-01-01 23:00:00'),
       (9, 5, 'durasteel K9', '4000-01-01 07:00:00', '4000-01-01 15:00:00'),
       (10, 5, 'durasteel K9', '4000-01-01 15:00:00', '4000-01-01 23:00:00');

insert into Workers (pass_id, shift_no, full_name, position, date_of_emplyment)
values (98343, 1, 'Smith P.E.', 'shiftman', '1987-10-23'),
       (32200, 1, 'James E.M.', 'electrician', '1987-10-27'),
       (26394, 1, 'Williams  A.C.', 'steelmaker', '1987-06-20'),
       (36190, 1, 'Jones  S.B.', 'electric welder', '1988-05-23'),
       (22153, 1, 'Brown  S.E.', 'electrician', '1987-05-28'),
       (37045, 1, 'Davis  E.S.', 'electric welder', '1990-04-28'),
       (20977, 1, 'Miller  O.G.', 'heat treater', '1987-06-20'),
       (31410, 1, 'Wilson  G.D.', 'electrician', '1987-10-23'),
       (38792, 1, 'Moore  O.V.', 'electrician', '1991-04-22'),
       (90959, 1, 'Taylor  O.G.', 'steelmaker', '1987-04-18'),
       (54021, 2, 'Anderson  D.D.', 'shiftman', '1987-04-18'),
       (45887, 2, 'Jones  O.P.', 'heat treater', '1987-04-18'),
       (63185, 2, 'Thomas  S.M.', 'heat treater', '1988-05-23'),
       (86069, 2, 'Jackson  P.M.', 'rollerman', '1989-12-30'),
       (16793, 2, 'White  C.S.', 'steelmaker', '1988-08-10'),
       (20616, 2, 'Thomas  S.G.', 'heat treater', '1988-05-23'),
       (51330, 2, 'Wilson  V.Z.', 'steelmaker', '1987-04-18'),
       (17125, 2, 'Harris  E.P.', 'electric welder', '1988-09-30'),
       (83043, 2, 'Martin  M.E.', 'steelmaker', '1990-04-01'),
       (22224, 2, 'Thompson  S.A.', 'caster', '1987-06-20'),
       (96985, 3, 'Wood  S.D.', 'shiftman', '1989-04-23'),
       (77257, 3, 'Moore  A.Z.', 'heat treater', '1991-04-22'),
       (97368, 3, 'Lewis  S.P.', 'heat treater', '1970-01-17'),
       (64916, 3, 'Anderson  P.S.', 'electrician', '1989-12-30'),
       (41431, 3, 'Scott  D.V.', 'steelmaker', '1988-05-23'),
       (26433, 3, 'White  G.M.', 'steelmaker', '1989-04-23'),
       (68788, 3, 'Anderson  S.C.', 'rollerman', '1990-04-28'),
       (50801, 3, 'Cooper  B.A.', 'heat treater', '1987-04-18'),
       (57774, 3, 'James C.M.', 'electrician', '1988-05-23'),
       (10636, 3, 'Smith O.D.', 'rollerman', '1987-06-20'),
       (47031, 4, 'Scott  D.A.', 'shiftman', '1988-04-05'),
       (85713, 4, 'King  C.M.', 'steelmaker', '1990-04-28'),
       (19173, 4, 'Lewis  B.G.', 'rollerman', '1988-09-30'),
       (33456, 4, 'Brown  Z.S.', 'rollerman', '1970-01-17'),
       (37697, 4, 'James D.D.', 'steelmaker', '1989-02-03'),
       (20250, 4, 'Harris  P.G.', 'rollerman', '1988-08-10'),
       (16537, 4, 'Green O.M.', 'electrician', '1990-04-01'),
       (83725, 4, 'Anderson  Z.E.', 'caster', '1988-04-05'),
       (22019, 4, 'Walker C.C.', 'steelmaker', '1990-04-01'),
       (36350, 4, 'Davis  O.M.', 'electrician', '1991-04-22'),
       (37074, 5, 'Brown  D.B.', 'shiftman', '1988-04-05'),
       (58150, 5, 'Edwards O.A.', 'heat treater', '1990-04-28'),
       (81020, 5, 'Jackson  A.Z.', 'electric welder', '1991-04-22'),
       (55863, 5, 'Lewis  W.D.', 'heat treater', '1988-04-05'),
       (78999, 5, 'Moore  S.W.', 'heat treater', '1987-05-28'),
       (48091, 5, 'Harris  B.G.', 'electric welder', '1989-06-22'),
       (95751, 5, 'Wilson  S.O.', 'caster', '1990-04-28'),
       (70963, 5, 'Edwards B.D.', 'rollerman', '1989-12-30'),
       (56337, 5, 'Turner E.P.', 'electric welder', '1989-12-30'),
       (26152, 5, 'Smith M.S.', 'rollerman', '1989-06-22'),
       (34835, 6, 'Miller  P.D.', 'shiftman', '1988-09-30'),
       (50245, 6, 'Morgan S.C.', 'caster', '1988-09-30'),
       (46003, 6, 'Cooper  M.B.', 'heat treater', '1989-12-30'),
       (45994, 6, 'Thompson  A.O.', 'heat treater', '1987-11-25'),
       (44595, 6, 'Manson G.Z.', 'steelmaker', '1989-12-30'),
       (74917, 6, 'Anderson  D.V.', 'electrician', '1990-04-28'),
       (61302, 6, 'Miller  A.S.', 'electric welder', '1987-06-17'),
       (95704, 6, 'Baker P.M.', 'rollerman', '1987-06-20'),
       (64903, 6, 'Hill W.M.', 'caster', '1989-06-22'),
       (73393, 6, 'Jones  W.B.', 'rollerman', '1988-09-30'),
       (36377, 7, 'Cooper  M.W.', 'shiftman', '1988-05-23'),
       (71314, 7, 'Phillips D.V.', 'electric welder', '1988-04-05'),
       (25015, 7, 'Hill V.M.', 'rollerman', '1989-06-22'),
       (37138, 7, 'Morgan Z.G.', 'rollerman', '1989-04-23'),
       (57715, 7, 'Thomas  S.D.', 'electric welder', '1987-06-20'),
       (58771, 7, 'Cooper  S.G.', 'caster', '1987-10-27'),
       (59505, 7, 'Smith M.D.', 'steelmaker', '1987-11-25'),
       (76891, 7, 'Baker W.D.', 'rollerman', '1989-12-30'),
       (25255, 7, 'Baker V.W.', 'caster', '1989-02-03'),
       (79889, 7, 'Williams  M.D.', 'caster', '1990-04-28'),
       (63401, 8, 'Jones  G.O.', 'shiftman', '1990-04-01'),
       (75067, 8, 'Cooper  P.A.', 'heat treater', '1987-06-20'),
       (46078, 8, 'Hill P.O.', 'heat treater', '1991-04-22'),
       (87633, 8, 'James G.V.', 'caster', '1989-06-22'),
       (31937, 8, 'Brown  B.C.', 'heat treater', '1989-06-22'),
       (13238, 8, 'Jones  S.A.', 'steelmaker', '1988-09-30'),
       (50276, 8, 'Walker D.A.', 'electrician', '1987-10-23'),
       (11815, 8, 'Thompson  S.C.', 'rollerman', '1988-04-05'),
       (93761, 8, 'Cooper  A.O.', 'heat treater', '1991-04-22'),
       (10115, 8, 'Jones  V.P.', 'electric welder', '1989-02-03'),
       (80815, 9, 'Morgan O.Z.', 'shiftman', '1988-04-05'),
       (70861, 9, 'King  S.Z.', 'steelmaker', '1989-04-23'),
       (23731, 9, 'Clifford P.M.', 'electrician', '1987-11-25'),
       (25609, 9, 'Smith B.G.', 'caster', '1987-04-18'),
       (33653, 9, 'Edwards P.A.', 'heat treater', '1988-05-23'),
       (39398, 9, 'Lewis  G.D.', 'steelmaker', '1989-02-03'),
       (89967, 9, 'Scott  C.S.', 'rollerman', '1987-10-23'),
       (11428, 9, 'Anderson  S.E.', 'electrician', '1989-02-03'),
       (72259, 9, 'Baker M.V.', 'caster', '1988-09-30'),
       (55705, 9, 'Smith W.M.', 'heat treater', '1989-06-22'),
       (32419, 10, 'Wilson  W.W.', 'shiftman', '1987-06-20'),
       (25599, 10, 'King  S.D.', 'heat treater', '1990-04-28'),
       (50368, 10, 'Smith W.A.', 'caster', '1988-04-05'),
       (68428, 10, 'Moore  S.P.', 'electrician', '1970-01-17'),
       (69477, 10, 'Wilson  A.S.', 'rollerman', '1987-06-17'),
       (21094, 10, 'Taylor  Z.D.', 'steelmaker', '1989-02-03'),
       (70252, 10, 'Hill A.S.', 'electric welder', '1987-10-23'),
       (19274, 10, 'Wood  O.D.', 'rollerman', '1987-05-28'),
       (99537, 10, 'Moore  A.C.', 'electrician', '1970-01-17'),
       (51266, 10, 'Thompson  S.O.', 'rollerman', '1970-01-17');

insert into Products_per_day_by_shift (date, shift_no, number_of_produced_production)
values ('2018-04-1', 1, 247),
       ('2018-04-1', 2, 220),
       ('2018-04-1', 3, 219),
       ('2018-04-1', 4, 224),
       ('2018-04-1', 5, 231),
       ('2018-04-1', 6, 233),
       ('2018-04-1', 7, 82),
       ('2018-04-1', 8, 82),
       ('2018-04-1', 9, 112),
       ('2018-04-1', 10, 90),
       ('2018-04-2', 1, 232),
       ('2018-04-2', 2, 232),
       ('2018-04-2', 3, 239),
       ('2018-04-2', 4, 218),
       ('2018-04-2', 5, 226),
       ('2018-04-2', 6, 241),
       ('2018-04-2', 7, 113),
       ('2018-04-2', 8, 76),
       ('2018-04-2', 9, 89),
       ('2018-04-2', 10, 81),
       ('2018-04-3', 1, 224),
       ('2018-04-3', 2, 244),
       ('2018-04-3', 3, 247),
       ('2018-04-3', 4, 247),
       ('2018-04-3', 5, 249),
       ('2018-04-3', 6, 216),
       ('2018-04-3', 7, 105),
       ('2018-04-3', 8, 95),
       ('2018-04-3', 9, 104),
       ('2018-04-3', 10, 79),
       ('2018-04-4', 1, 212),
       ('2018-04-4', 2, 220),
       ('2018-04-4', 3, 246),
       ('2018-04-4', 4, 230),
       ('2018-04-4', 5, 242),
       ('2018-04-4', 6, 237),
       ('2018-04-4', 7, 112),
       ('2018-04-4', 8, 97),
       ('2018-04-4', 9, 104),
       ('2018-04-4', 10, 76),
       ('2018-04-5', 1, 228),
       ('2018-04-5', 2, 224),
       ('2018-04-5', 3, 217),
       ('2018-04-5', 4, 225),
       ('2018-04-5', 5, 226),
       ('2018-04-5', 6, 236),
       ('2018-04-5', 7, 107),
       ('2018-04-5', 8, 93),
       ('2018-04-5', 9, 105),
       ('2018-04-5', 10, 84),
       ('2018-04-6', 1, 220),
       ('2018-04-6', 2, 233),
       ('2018-04-6', 3, 213),
       ('2018-04-6', 4, 212),
       ('2018-04-6', 5, 214),
       ('2018-04-6', 6, 237),
       ('2018-04-6', 7, 92),
       ('2018-04-6', 8, 96),
       ('2018-04-6', 9, 98),
       ('2018-04-6', 10, 101),
       ('2018-04-7', 1, 243),
       ('2018-04-7', 2, 213),
       ('2018-04-7', 3, 237),
       ('2018-04-7', 4, 227),
       ('2018-04-7', 5, 215),
       ('2018-04-7', 6, 219),
       ('2018-04-7', 7, 91),
       ('2018-04-7', 8, 77),
       ('2018-04-7', 9, 109),
       ('2018-04-7', 10, 107),
       ('2018-04-8', 1, 224),
       ('2018-04-8', 2, 249),
       ('2018-04-8', 3, 219),
       ('2018-04-8', 4, 215),
       ('2018-04-8', 5, 233),
       ('2018-04-8', 6, 212),
       ('2018-04-8', 7, 90),
       ('2018-04-8', 8, 111),
       ('2018-04-8', 9, 105),
       ('2018-04-8', 10, 78),
       ('2018-04-9', 1, 240),
       ('2018-04-9', 2, 241),
       ('2018-04-9', 3, 239),
       ('2018-04-9', 4, 217),
       ('2018-04-9', 5, 239),
       ('2018-04-9', 6, 246),
       ('2018-04-9', 7, 98),
       ('2018-04-9', 8, 93),
       ('2018-04-9', 9, 75),
       ('2018-04-9', 10, 104),
       ('2018-04-10', 1, 241),
       ('2018-04-10', 2, 237),
       ('2018-04-10', 3, 214),
       ('2018-04-10', 4, 223),
       ('2018-04-10', 5, 236),
       ('2018-04-10', 6, 233),
       ('2018-04-10', 7, 82),
       ('2018-04-10', 8, 91),
       ('2018-04-10', 9, 113),
       ('2018-04-10', 10, 82),
       ('2018-04-11', 1, 240),
       ('2018-04-11', 2, 233),
       ('2018-04-11', 3, 228),
       ('2018-04-11', 4, 246),
       ('2018-04-11', 5, 218),
       ('2018-04-11', 6, 231),
       ('2018-04-11', 7, 105),
       ('2018-04-11', 8, 113),
       ('2018-04-11', 9, 81),
       ('2018-04-11', 10, 83),
       ('2018-04-12', 1, 242),
       ('2018-04-12', 2, 220),
       ('2018-04-12', 3, 219),
       ('2018-04-12', 4, 217),
       ('2018-04-12', 5, 232),
       ('2018-04-12', 6, 233),
       ('2018-04-12', 7, 96),
       ('2018-04-12', 8, 96),
       ('2018-04-12', 9, 99),
       ('2018-04-12', 10, 114),
       ('2018-04-13', 1, 235),
       ('2018-04-13', 2, 217),
       ('2018-04-13', 3, 226),
       ('2018-04-13', 4, 227),
       ('2018-04-13', 5, 230),
       ('2018-04-13', 6, 220),
       ('2018-04-13', 7, 90),
       ('2018-04-13', 8, 113),
       ('2018-04-13', 9, 96),
       ('2018-04-13', 10, 113),
       ('2018-04-14', 1, 214),
       ('2018-04-14', 2, 219),
       ('2018-04-14', 3, 223),
       ('2018-04-14', 4, 240),
       ('2018-04-14', 5, 211),
       ('2018-04-14', 6, 230),
       ('2018-04-14', 7, 89),
       ('2018-04-14', 8, 86),
       ('2018-04-14', 9, 98),
       ('2018-04-14', 10, 104),
       ('2018-04-15', 1, 238),
       ('2018-04-15', 2, 241),
       ('2018-04-15', 3, 226),
       ('2018-04-15', 4, 224),
       ('2018-04-15', 5, 235),
       ('2018-04-15', 6, 235),
       ('2018-04-15', 7, 96),
       ('2018-04-15', 8, 83),
       ('2018-04-15', 9, 75),
       ('2018-04-15', 10, 104),
       ('2018-04-16', 1, 227),
       ('2018-04-16', 2, 236),
       ('2018-04-16', 3, 248),
       ('2018-04-16', 4, 234),
       ('2018-04-16', 5, 215),
       ('2018-04-16', 6, 224),
       ('2018-04-16', 7, 96),
       ('2018-04-16', 8, 97),
       ('2018-04-16', 9, 84),
       ('2018-04-16', 10, 76),
       ('2018-04-17', 1, 246),
       ('2018-04-17', 2, 232),
       ('2018-04-17', 3, 248),
       ('2018-04-17', 4, 210),
       ('2018-04-17', 5, 239),
       ('2018-04-17', 6, 218),
       ('2018-04-17', 7, 101),
       ('2018-04-17', 8, 80),
       ('2018-04-17', 9, 101),
       ('2018-04-17', 10, 76),
       ('2018-04-18', 1, 216),
       ('2018-04-18', 2, 240),
       ('2018-04-18', 3, 220),
       ('2018-04-18', 4, 238),
       ('2018-04-18', 5, 223),
       ('2018-04-18', 6, 235),
       ('2018-04-18', 7, 98),
       ('2018-04-18', 8, 94),
       ('2018-04-18', 9, 80),
       ('2018-04-18', 10, 102),
       ('2018-04-19', 1, 241),
       ('2018-04-19', 2, 241),
       ('2018-04-19', 3, 213),
       ('2018-04-19', 4, 230),
       ('2018-04-19', 5, 220),
       ('2018-04-19', 6, 212),
       ('2018-04-19', 7, 94),
       ('2018-04-19', 8, 90),
       ('2018-04-19', 9, 81),
       ('2018-04-19', 10, 112),
       ('2018-04-20', 1, 233),
       ('2018-04-20', 2, 223),
       ('2018-04-20', 3, 223),
       ('2018-04-20', 4, 210),
       ('2018-04-20', 5, 214),
       ('2018-04-20', 6, 217),
       ('2018-04-20', 7, 102),
       ('2018-04-20', 8, 92),
       ('2018-04-20', 9, 112),
       ('2018-04-20', 10, 81),
       ('2018-04-21', 1, 241),
       ('2018-04-21', 2, 218),
       ('2018-04-21', 3, 216),
       ('2018-04-21', 4, 223),
       ('2018-04-21', 5, 226),
       ('2018-04-21', 6, 221),
       ('2018-04-21', 7, 85),
       ('2018-04-21', 8, 97),
       ('2018-04-21', 9, 107),
       ('2018-04-21', 10, 82),
       ('2018-04-22', 1, 214),
       ('2018-04-22', 2, 249),
       ('2018-04-22', 3, 235),
       ('2018-04-22', 4, 211),
       ('2018-04-22', 5, 218),
       ('2018-04-22', 6, 227),
       ('2018-04-22', 7, 107),
       ('2018-04-22', 8, 76),
       ('2018-04-22', 9, 88),
       ('2018-04-22', 10, 96),
       ('2018-04-23', 1, 211),
       ('2018-04-23', 2, 243),
       ('2018-04-23', 3, 226),
       ('2018-04-23', 4, 217),
       ('2018-04-23', 5, 229),
       ('2018-04-23', 6, 231),
       ('2018-04-23', 7, 92),
       ('2018-04-23', 8, 98),
       ('2018-04-23', 9, 75),
       ('2018-04-23', 10, 88),
       ('2018-04-24', 1, 218),
       ('2018-04-24', 2, 231),
       ('2018-04-24', 3, 246),
       ('2018-04-24', 4, 214),
       ('2018-04-24', 5, 238),
       ('2018-04-24', 6, 211),
       ('2018-04-24', 7, 99),
       ('2018-04-24', 8, 78),
       ('2018-04-24', 9, 86),
       ('2018-04-24', 10, 87),
       ('2018-04-25', 1, 224),
       ('2018-04-25', 2, 221),
       ('2018-04-25', 3, 223),
       ('2018-04-25', 4, 234),
       ('2018-04-25', 5, 233),
       ('2018-04-25', 6, 237),
       ('2018-04-25', 7, 97),
       ('2018-04-25', 8, 111),
       ('2018-04-25', 9, 76),
       ('2018-04-25', 10, 95),
       ('2018-04-26', 1, 238),
       ('2018-04-26', 2, 237),
       ('2018-04-26', 3, 223),
       ('2018-04-26', 4, 230),
       ('2018-04-26', 5, 210),
       ('2018-04-26', 6, 249),
       ('2018-04-26', 7, 75),
       ('2018-04-26', 8, 100),
       ('2018-04-26', 9, 83),
       ('2018-04-26', 10, 78),
       ('2018-04-27', 1, 244),
       ('2018-04-27', 2, 236),
       ('2018-04-27', 3, 230),
       ('2018-04-27', 4, 242),
       ('2018-04-27', 5, 242),
       ('2018-04-27', 6, 247),
       ('2018-04-27', 7, 113),
       ('2018-04-27', 8, 111),
       ('2018-04-27', 9, 97),
       ('2018-04-27', 10, 108),
       ('2018-04-28', 1, 222),
       ('2018-04-28', 2, 249),
       ('2018-04-28', 3, 216),
       ('2018-04-28', 4, 245),
       ('2018-04-28', 5, 231),
       ('2018-04-28', 6, 249),
       ('2018-04-28', 7, 113),
       ('2018-04-28', 8, 87),
       ('2018-04-28', 9, 113),
       ('2018-04-28', 10, 104),
       ('2018-04-29', 1, 211),
       ('2018-04-29', 2, 214),
       ('2018-04-29', 3, 223),
       ('2018-04-29', 4, 235),
       ('2018-04-29', 5, 221),
       ('2018-04-29', 6, 239),
       ('2018-04-29', 7, 106),
       ('2018-04-29', 8, 112),
       ('2018-04-29', 9, 76),
       ('2018-04-29', 10, 112),
       ('2018-04-30', 1, 250),
       ('2018-04-30', 2, 216),
       ('2018-04-30', 3, 235),
       ('2018-04-30', 4, 214),
       ('2018-04-30', 5, 210),
       ('2018-04-30', 6, 227),
       ('2018-04-30', 7, 114),
       ('2018-04-30', 8, 94),
       ('2018-04-30', 9, 98),
       ('2018-04-30', 10, 105);

insert into Production_value(type_of_product, date_value_start, date_value_end, value)
VALUES ('steel 15XCHD', '2010-01-01', '2011-07-27', 1560),
       ('steel 15XCHD', '2011-07-28', '2012-02-10', 1472),
       ('steel 15XCHD', '2012-02-11', '2013-03-31', 1365),
       ('steel 15XCHD', '2013-04-01', '2014-07-20', 1487),
       ('steel 15XCHD', '2014-07-21', '2014-12-15', 1585),
       ('steel 15XCHD', '2014-12-16', '2015-03-24', 1473),
       ('steel 15XCHD', '2015-03-25', '2015-09-01', 1413),
       ('steel 15XCHD', '2015-09-02', '2016-04-15', 1399),
       ('steel 15XCHD', '2016-04-16', '2018-02-17', 1478),
       ('steel 15XCHD', '2018-02-18', '2018-04-04', 1460),
       ('steel 15XCHD', '2018-04-05', '2019-08-10', 1393),
       ('steel 15XCHD', '2019-08-11', '2020-09-22', 1501),
       ('steel 15XCHD', '2020-09-23', '2021-02-01', 1553),
       ('steel 15XCHD', '2021-02-02', '2021-05-15', 1486),
       ('steel 15XCHD', '2021-05-16', '2023-04-03', 1500),
       ('steel 15XCHD', '2023-04-04', '2024-05-16', 1451),
       ('steel 15XCHD', '2024-05-17', '2025-11-10', 1357),
       ('steel 15XCHD', '2025-11-11', '4000-01-01', 1231),
       ('steel P5', '2010-01-01', '2010-04-16', 1470),
       ('steel P5', '2010-04-17', '2011-10-15', 1377),
       ('steel P5', '2011-10-16', '2012-12-02', 1239),
       ('steel P5', '2012-12-03', '2013-07-22', 1311),
       ('steel P5', '2013-07-23', '2014-11-13', 1183),
       ('steel P5', '2014-11-14', '2015-02-18', 1295),
       ('steel P5', '2015-02-19', '2015-03-14', 1177),
       ('steel P5', '2015-03-15', '2015-06-15', 1217),
       ('steel P5', '2015-06-16', '2017-01-08', 1361),
       ('steel P5', '2017-01-09', '2018-02-04', 1395),
       ('steel P5', '2018-02-05', '2019-11-17', 1271),
       ('steel P5', '2019-11-18', '2021-05-17', 1319),
       ('steel P5', '2021-05-18', '2022-07-26', 1298),
       ('steel P5', '2022-07-27', '2023-10-26', 1298),
       ('steel P5', '2023-10-27', '2025-09-07', 1233),
       ('steel P5', '2025-09-08', '2026-09-08', 1342),
       ('steel P5', '2026-09-09', '2027-03-10', 1252),
       ('steel P5', '2027-03-11', '2028-04-05', 1376),
       ('steel P5', '2028-04-06', '2030-01-01', 1356),
       ('steel P5', '2030-01-02', '2030-10-11', 1458),
       ('steel P5', '2030-10-12', '2031-10-26', 1405),
       ('steel P5', '2031-10-27', '2032-05-15', 1271),
       ('steel P5', '2032-05-16', '2032-12-19', 1400),
       ('steel P5', '2032-12-20', '2034-10-19', 1418),
       ('steel P5', '2034-10-20', '2035-09-19', 1473),
       ('steel P5', '2035-09-20', '2037-05-22', 1551),
       ('steel P5', '2037-05-23', '4000-01-01', 1498),
       ('steel SHX4', '2010-01-01', '2011-09-14', 1529),
       ('steel SHX4', '2011-09-15', '2012-04-06', 1566),
       ('steel SHX4', '2012-04-07', '2012-09-10', 1426),
       ('steel SHX4', '2012-09-11', '2014-05-11', 1291),
       ('steel SHX4', '2014-05-12', '2014-08-24', 1233),
       ('steel SHX4', '2014-08-25', '2014-12-25', 1212),
       ('steel SHX4', '2014-12-26', '2015-04-04', 1243),
       ('steel SHX4', '2015-04-05', '2016-12-08', 1329),
       ('steel SHX4', '2016-12-09', '2017-07-09', 1246),
       ('steel SHX4', '2017-07-10', '2019-05-21', 1288),
       ('steel SHX4', '2019-05-22', '2020-05-31', 1244),
       ('steel SHX4', '2020-06-01', '2020-08-13', 1316),
       ('steel SHX4', '2020-08-14', '2021-01-11', 1377),
       ('steel SHX4', '2021-01-12', '2021-07-23', 1447),
       ('steel SHX4', '2021-07-24', '2022-11-19', 1593),
       ('steel SHX4', '2022-11-20', '2023-01-22', 1574),
       ('steel SHX4', '2023-01-23', '2023-03-07', 1527),
       ('steel SHX4', '2023-03-08', '2024-07-25', 1587),
       ('steel SHX4', '2024-07-26', '2025-05-26', 1649),
       ('steel SHX4', '2025-05-27', '2026-11-02', 1784),
       ('steel SHX4', '2026-11-03', '2027-12-11', 1871),
       ('steel SHX4', '2027-12-12', '2028-03-05', 1915),
       ('steel SHX4', '2028-03-06', '2028-05-11', 1780),
       ('steel SHX4', '2028-05-12', '4000-01-01', 1755),
       ('durasteel 9DOG5', '2010-01-01', '2011-07-07', 2458),
       ('durasteel 9DOG5', '2011-07-08', '2013-02-21', 2397),
       ('durasteel 9DOG5', '2013-02-22', '2014-01-27', 2283),
       ('durasteel 9DOG5', '2014-01-28', '2014-04-08', 2348),
       ('durasteel 9DOG5', '2014-04-09', '2015-01-12', 2347),
       ('durasteel 9DOG5', '2015-01-13', '2015-08-13', 2297),
       ('durasteel 9DOG5', '2015-08-14', '2016-06-01', 2311),
       ('durasteel 9DOG5', '2016-06-02', '2018-03-24', 2450),
       ('durasteel 9DOG5', '2018-03-25', '2019-04-01', 2587),
       ('durasteel 9DOG5', '2019-04-02', '2020-07-20', 2608),
       ('durasteel 9DOG5', '2020-07-21', '4000-01-01', 2718),
       ('durasteel K9', '2010-01-01', '2010-06-14', 2332),
       ('durasteel K9', '2010-06-15', '2010-10-29', 2420),
       ('durasteel K9', '2010-10-30', '2011-03-09', 2304),
       ('durasteel K9', '2011-03-10', '2012-06-03', 2170),
       ('durasteel K9', '2012-06-04', '2013-11-09', 2223),
       ('durasteel K9', '2013-11-10', '2014-08-26', 2309),
       ('durasteel K9', '2014-08-27', '2015-05-16', 2394),
       ('durasteel K9', '2015-05-17', '2015-08-10', 2416),
       ('durasteel K9', '2015-08-11', '2015-11-27', 2279),
       ('durasteel K9', '2015-11-28', '2016-01-16', 2220),
       ('durasteel K9', '2016-01-17', '2017-11-24', 2237),
       ('durasteel K9', '2017-11-25', '2019-03-08', 2173),
       ('durasteel K9', '2019-03-09', '2020-02-21', 2071),
       ('durasteel K9', '2020-02-22', '2022-01-17', 1950),
       ('durasteel K9', '2022-01-18', '2022-04-27', 1906),
       ('durasteel K9', '2022-04-28', '2023-06-12', 1969),
       ('durasteel K9', '2023-06-13', '2025-04-05', 1858),
       ('durasteel K9', '2025-04-06', '2026-01-13', 1797),
       ('durasteel K9', '2026-01-14', '2026-07-21', 1874),
       ('durasteel K9', '2026-07-22', '2028-01-22', 1876),
       ('durasteel K9', '2028-01-23', '2028-07-02', 1997),
       ('durasteel K9', '2028-07-03', '2029-01-21', 1937),
       ('durasteel K9', '2029-01-22', '2029-11-06', 1987),
       ('durasteel K9', '2029-11-07', '2030-04-02', 1881),
       ('durasteel K9', '2030-04-03', '2032-01-25', 1764),
       ('durasteel K9', '2032-01-26', '2033-03-14', 1685),
       ('durasteel K9', '2033-03-15', '4000-01-01', 1587);

insert into Material(type_of_materials)
values ('magnet ore'),
       ('iron'),
       ('aluminum alloy'),
       ('duraluminum alloy'),
       ('wolfram');

insert into Required_materials(type_of_product, type_of_materials)
VALUES ('steel 15XCHD', 'magnet ore'),
       ('steel P5', 'iron'),
       ('steel SHX4', 'aluminum alloy'),
       ('durasteel 9DOG5', 'duraluminum alloy'),
       ('durasteel K9', 'wolfram');

insert into Materials_cost(type_of_materials, date_cost_start, date_cost_end, cost)
VALUES ('magnet ore', '2010-01-01', '2010-06-20', 687),
       ('magnet ore', '2010-06-21', '2011-02-26', 739),
       ('magnet ore', '2011-02-27', '2011-09-26', 786),
       ('magnet ore', '2011-09-27', '2013-05-27', 775),
       ('magnet ore', '2013-05-28', '2014-05-05', 720),
       ('magnet ore', '2014-05-06', '2016-03-30', 678),
       ('magnet ore', '2016-03-31', '2017-04-23', 708),
       ('magnet ore', '2017-04-24', '2019-02-13', 687),
       ('magnet ore', '2019-02-14', '2019-05-31', 657),
       ('magnet ore', '2019-06-01', '2020-10-22', 674),
       ('magnet ore', '2020-10-23', '2020-12-23', 654),
       ('magnet ore', '2020-12-24', '2021-03-08', 718),
       ('magnet ore', '2021-03-09', '2022-09-24', 706),
       ('magnet ore', '2022-09-25', '2024-07-06', 714),
       ('magnet ore', '2024-07-07', '2024-10-26', 711),
       ('magnet ore', '2024-10-27', '2024-12-16', 665),
       ('magnet ore', '2024-12-17', '2025-12-12', 712),
       ('magnet ore', '2025-12-13', '2026-07-01', 718),
       ('magnet ore', '2026-07-02', '2027-01-29', 727),
       ('magnet ore', '2027-01-30', '2027-05-22', 762),
       ('magnet ore', '2027-05-23', '2027-09-25', 703),
       ('iron', '2010-01-01', '2011-02-22', 678),
       ('iron', '2011-02-23', '2012-04-07', 644),
       ('iron', '2012-04-08', '2013-06-28', 708),
       ('iron', '2013-06-29', '2014-12-16', 757),
       ('iron', '2014-12-17', '2015-08-02', 815),
       ('iron', '2015-08-03', '2015-12-05', 814),
       ('iron', '2015-12-06', '2016-02-08', 758),
       ('aluminum alloy', '2010-01-01', '2010-11-27', 652),
       ('aluminum alloy', '2010-11-28', '2012-07-04', 619),
       ('aluminum alloy', '2012-07-05', '2012-09-27', 656),
       ('aluminum alloy', '2012-09-28', '2014-04-16', 656),
       ('aluminum alloy', '2014-04-17', '2014-07-04', 696),
       ('aluminum alloy', '2014-07-05', '2016-03-30', 766),
       ('aluminum alloy', '2016-03-31', '2016-07-09', 775),
       ('aluminum alloy', '2016-07-10', '2017-01-15', 766),
       ('aluminum alloy', '2017-01-16', '2017-03-08', 818),
       ('aluminum alloy', '2017-03-09', '2017-08-11', 864),
       ('aluminum alloy', '2017-08-12', '2017-11-19', 804),
       ('aluminum alloy', '2017-11-20', '2019-05-03', 848),
       ('aluminum alloy', '2019-05-04', '2019-08-21', 805),
       ('aluminum alloy', '2019-08-22', '2020-09-29', 819),
       ('aluminum alloy', '2020-09-30', '2022-04-07', 809),
       ('aluminum alloy', '2022-04-08', '2022-12-29', 847),
       ('aluminum alloy', '2022-12-30', '2024-07-05', 882),
       ('aluminum alloy', '2024-07-06', '2024-12-07', 937),
       ('aluminum alloy', '2024-12-08', '2026-05-29', 942),
       ('aluminum alloy', '2026-05-30', '2026-09-05', 979),
       ('aluminum alloy', '2026-09-06', '2027-06-04', 1004),
       ('aluminum alloy', '2027-06-05', '2029-04-24', 947),
       ('aluminum alloy', '2029-04-25', '2030-01-14', 906),
       ('aluminum alloy', '2030-01-15', '2030-11-13', 892),
       ('aluminum alloy', '2030-11-14', '2030-12-18', 873),
       ('aluminum alloy', '2030-12-19', '2031-11-01', 916),
       ('aluminum alloy', '2031-11-02', '2032-02-01', 884),
       ('aluminum alloy', '2032-02-02', '2033-11-04', 859),
       ('duraluminum alloy', '2010-01-01', '2010-07-06', 1168),
       ('duraluminum alloy', '2010-07-07', '2011-11-11', 1120),
       ('duraluminum alloy', '2011-11-12', '2012-09-24', 1164),
       ('duraluminum alloy', '2012-09-25', '2014-07-11', 1168),
       ('duraluminum alloy', '2014-07-12', '2015-03-22', 1221),
       ('duraluminum alloy', '2015-03-23', '2015-04-03', 1166),
       ('duraluminum alloy', '2015-04-04', '2016-01-13', 1126),
       ('duraluminum alloy', '2016-01-14', '2016-09-06', 1169),
       ('duraluminum alloy', '2016-09-07', '2018-01-12', 1143),
       ('duraluminum alloy', '2018-01-13', '2018-05-03', 1137),
       ('duraluminum alloy', '2018-05-04', '2019-04-06', 1182),
       ('duraluminum alloy', '2019-04-07', '2020-02-18', 1212),
       ('duraluminum alloy', '2020-02-19', '2020-05-25', 1270),
       ('duraluminum alloy', '2020-05-26', '2021-01-01', 1314),
       ('duraluminum alloy', '2021-01-02', '2021-12-14', 1376),
       ('duraluminum alloy', '2021-12-15', '2023-05-26', 1359),
       ('duraluminum alloy', '2023-05-27', '2023-12-09', 1299),
       ('duraluminum alloy', '2023-12-10', '2025-03-21', 1345),
       ('duraluminum alloy', '2025-03-22', '2026-11-01', 1411),
       ('duraluminum alloy', '2026-11-02', '2028-01-28', 1354),
       ('duraluminum alloy', '2028-01-29', '2029-02-07', 1329),
       ('duraluminum alloy', '2029-02-08', '2030-05-21', 1347),
       ('duraluminum alloy', '2030-05-22', '2031-03-09', 1376),
       ('wolfram', '2010-01-01', '2011-11-04', 1071),
       ('wolfram', '2011-11-05', '2012-11-01', 1058),
       ('wolfram', '2012-11-02', '2014-02-09', 1100),
       ('wolfram', '2014-02-10', '2014-07-27', 1141),
       ('wolfram', '2014-07-28', '2014-10-17', 1120),
       ('wolfram', '2014-10-18', '2014-11-07', 1119),
       ('wolfram', '2014-11-08', '2015-01-20', 1072),
       ('wolfram', '2015-01-21', '2016-11-25', 1084),
       ('wolfram', '2016-11-26', '2017-12-17', 1115),
       ('wolfram', '2017-12-18', '2018-04-21', 1180),
       ('wolfram', '2018-04-22', '2020-02-24', 1176),
       ('wolfram', '2020-02-25', '2021-07-13', 1210),
       ('wolfram', '2021-07-14', '2022-12-13', 1196),
       ('wolfram', '2022-12-14', '2023-06-22', 1154),
       ('wolfram', '2023-06-23', '2024-05-26', 1141),
       ('wolfram', '2024-05-27', '2025-10-01', 1129),
       ('wolfram', '2025-10-02', '2026-06-21', 1162),
       ('wolfram', '2026-06-22', '2027-07-23', 1213),
       ('wolfram', '2027-07-24', '2028-10-06', 1183),
       ('wolfram', '2028-10-07', '2030-04-09', 1250),
       ('wolfram', '2030-04-10', '2031-06-11', 1216),
       ('wolfram', '2031-06-12', '2032-02-05', 1200),
       ('wolfram', '2032-02-06', '2033-07-23', 1164),
       ('wolfram', '2033-07-24', '2035-04-10', 1199),
       ('wolfram', '2035-04-11', '2036-10-29', 1257),
       ('wolfram', '2036-10-30', '2037-07-11', 1239),
       ('wolfram', '2037-07-12', '2038-07-08', 1255),
       ('wolfram', '2038-07-09', '2040-05-01', 1298),
       ('wolfram', '2040-05-02', '2041-10-10', 1252);


select wsh.workshop_no,
       m.type_of_product
from Workshops wsh
join Machines m on m.workshop_no = wsh.workshop_no;


select shift_no,
       cast(avg(number_of_produced_production) as decimal(10))
from Products_per_day_by_shift
group by shift_no
order by shift_no;


select wr.full_name,
       wr.shift_no
from shifts sh
join Workers wr on wr.shift_no = sh.shift_no
where sh.start_time = (select max(start_time) from Shifts) and wr.position = 'shiftman';


with actual_material_cost as (select m_c.type_of_materials,
        m_c.cost
 from Materials_cost as m_c,
      (select type_of_materials,
              max(date_cost_start) as last_date
       from Materials_cost
       group by type_of_materials) as q
 where m_c.type_of_materials = q.type_of_materials
   and m_c.date_cost_start = q.last_date),
     first_material_cost as (select m_c.type_of_materials,
        m_c.cost
 from Materials_cost as m_c,
      (select type_of_materials,
              min(date_cost_start) as last_date
       from Materials_cost
       group by type_of_materials) as q
 where m_c.type_of_materials = q.type_of_materials
   and m_c.date_cost_start = q.last_date)
select a_m_c.type_of_materials,
       a_m_c.cost - f_m_c.cost as delta
from actual_material_cost a_m_c
join first_material_cost f_m_c on a_m_c.type_of_materials = f_m_c.type_of_materials;


with product_per_month as (
  select shift_no,
         sum(number_of_produced_production) as sum
  from Products_per_day_by_shift
  group by shift_no
),
     actual_product_value as (
       select p.type_of_product,
              p.value
       from Production_value as p,
            (select type_of_product,
                    max(date_value_start) as last_date
             from Production_value
             group by type_of_product) as q
       where p.type_of_product = q.type_of_product
         and p.date_value_start = q.last_date)
select t.shift_no,
       t.sum * a_p_v.value as income
from (select sh.shift_no,
             sh.type_of_product,
             p_p_m.sum
      from product_per_month p_p_m
             join shifts sh on sh.shift_no = p_p_m.shift_no) as t,
     actual_product_value a_p_v
where t.type_of_product = a_p_v.type_of_product
order by t.shift_no;

///

create or replace view actual_product_value as
  select p.type_of_product,
              p.value
       from Production_value as p,
            (select type_of_product,
                    max(date_value_start) as last_date
             from Production_value
             group by type_of_product) as q
       where p.type_of_product = q.type_of_product
         and p.date_value_start = q.last_date;

create or replace view actual_materials_cost as
  select m_c.type_of_materials,
        m_c.cost
 from Materials_cost as m_c,
      (select type_of_materials,
              max(date_cost_start) as last_date
       from Materials_cost
       group by type_of_materials) as q
 where m_c.type_of_materials = q.type_of_materials
   and m_c.date_cost_start = q.last_date;

create or replace view workshops_info as
  select wsh.workshop_no,
         m.type_of_product,
         m.machine_type
from Workshops wsh
join machines m on m.workshop_no = wsh.workshop_no;

create or replace view factory_worker as
  select shift_no,
         full_name,
         position
from Workers;

create or replace view last_day_production as
  select sh.type_of_product,
         sum(t.sum) as number
    from shifts sh
  join (select shift_no,
         sum(number_of_produced_production) as sum
  from Products_per_day_by_shift
  where date = (select max(date) from Products_per_day_by_shift)
  group by shift_no) as t on t.shift_no = sh.shift_no
group by sh.type_of_product;

create or replace view shifts_info as
  select shift_no,
         workshop_no,
         start_time,
         end_time
from Shifts;

create or replace view all_production_types as
  select * from Production;

create or replace view all_material_types as
  select * from Material;

select a_p_v.type_of_product,
       sum(l_d_p.sum*a_p_v.value) as income
from actual_product_value a_p_v, last_day_production l_d_p
where a_p_v.type_of_product = l_d_p.type_of_product
group by a_p_v.type_of_product;

select shift_no,
       full_name
from factory_worker
where position = 'steelmaker';

select * from workshops_info;

create view delta_cost as
  select a_p_v.type_of_product,
         a_p_v.value - stuffff.cost as delta
         from(select r_m.type_of_materials,
               cost,
               type_of_product
  from actual_materials_cost a_m_c
       join Required_materials r_m on a_m_c.type_of_materials = r_m.type_of_materials) as stuffff
join actual_product_value a_p_v on a_p_v.type_of_product = stuffff.type_of_product;

create view manufactoring_cost_per_day as
      select l_d_p.type_of_product,
             l_d_p.number*money.value as manufactoring_cost
             from (select a_p_v.type_of_product,
         a_p_v.value - d_c.delta as value
from actual_product_value a_p_v
join delta_cost d_c on d_c.type_of_product = a_p_v.type_of_product) as money
join last_day_production l_d_p on l_d_p.type_of_product = money.type_of_product
