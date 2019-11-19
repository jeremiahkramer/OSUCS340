
-- index.html
-- get all dealerships with addresses, hours, and names
SELECT dealership_name, hours, address_line_1, address_line_2, city, zip, country FROM dealership 
INNER JOIN dealership_address USING (address_id);
-- When you click on a dealership it will go to the details page and populate using that dealership name

-- dealershipAdd.html   TODO:MAKE INTO ONE QUERY
-- must insert into address first! foreign key constraint requires address id for dealership
INSERT INTO dealership_address (address_line_1, address_line_2, city, zip, country) 
VALUES (:address_line_1_input, :address_line_2_input, :city_input, :zip_input, :country_input);
INSERT INTO dealership (address_id, dealership_name, hours)
VALUES ((SELECT address_id FROM dealership_address WHERE address_line_1 = :address_line_1_input 
AND address_line_2 = :address_line_2_input AND city = :city_input AND zip = :zip_input 
AND country = :country_input), :dealership_name_input, :hours_input);

-- dealershipDetails.html
-- get the dealership that was clicked on (IS USED ON ALL CHILD PAGES)
SELECT dealership_name, hours, address_line_1, address_line_2, city, zip, country FROM dealership 
INNER JOIN dealership_address USING (address_id)
WHERE dealership_name = :dealership_name_clicked;
-- get number of employees
SELECT COUNT(employee_id) AS num_employees FROM employees 
WHERE dealership_id = (SELECT dealership_id FROM dealership WHERE dealership_name = :dealership_name_clicked);
-- get number of vehicles
SELECT COUNT(vehicle_id) AS num_vehicles FROM vehicle 
WHERE dealership_id = (SELECT dealership_id FROM dealership WHERE dealership_name = :dealership_name_clicked);
-- update a dealership
UPDATE dealership, dealership_address SET dealership_name = :dealership_name_input, hours = :hours_input, 
address_line_1 = :address_line_1_input, address_line_2 = :address_line_2_input, city = :city_input, zip = :zip_input, country = :country_input
WHERE dealership_id = (SELECT dealership_id FROM dealership WHERE dealership_name = :dealership_name_clicked)
AND dealership_address.address_id = dealership.address_id;
-- delete dealership, wont delete if there are any vehicles or employees in the dealership!
-- delete the dealership first, then the address
DELETE dealership, dealership_address FROM dealership INNER JOIN dealership_address USING (address_id)
WHERE dealership_id = (SELECT dealership_id FROM dealership WHERE dealership_name = :dealership_name_clicked);

-- employees.html
-- get employees of dealership
SELECT f_name, l_name, position FROM employees
WHERE dealership_id = (SELECT dealership_id FROM dealership WHERE dealership_name = :dealership_name_clicked);
-- update employee
UPDATE employees SET dealership_id = (SELECT dealership_id FROM dealership WHERE dealership_name = :dealership_name_input),
f_name = :f_name_input, l_name = :l_name_input, position = :position_input
WHERE employee_id = :employee_id_clicked;
-- delete employee
DELETE FROM employees WHERE employee_id = :employee_id_clicked;

-- employeeADD.html
INSERT INTO employees (dealership_id, f_name, l_name, position)
VALUES ((SELECT dealership_id FROM dealership WHERE dealership_name = :dealership_name_clicked), 
:f_name_input, :l_name_input, :position_input);

-- vehicle.html
-- get all vehicles for dealership
SELECT vehicle_id, type, vin FROM vehicle
WHERE dealership_id = (SELECT dealership_id FROM dealership WHERE dealership_name = :dealership_name_clicked);
-- update a vehicle
UPDATE vehicle SET dealership_id = (SELECT dealership_id FROM dealership WHERE dealership_name = :dealership_name_input),
type = :type_input, vin = :vin_input;
-- insert into vehicle_type if type_name doesnt exit
INSERT INTO vehicle_type (type_name) VALUES (:type_input)
WHERE NOT EXISTS (SELECT * FROM vehicle_type WHERE type_name = :type_input);
-- delete a vehicle
DELETE FROM vehicle WHERE vehicle_id = :vehicle_id_clicked;

-- vehicleAdd.html
INSERT INTO vehicle (dealership_id, type, vin)
VALUES ((SELECT dealership_id FROM dealership WHERE dealership_name = :dealership_name_clicked), 
:type_input, :vin_input;

-- vehicleDetails.html
-- get features for selected vehicle
SELECT feature_name, feature_description, feature_value FROM vehicle
INNER JOIN vehicle_feature USING (vehicle_id)
INNER JOIN feature USING (feature_id)
WHERE vehicle_id = :vehicle_id_clicked;
-- SHOULD NOT UPDATE A FEATURE HERE CAUSE A FEATURE CAN BE FOR MANY VEHICLES
-- remove a feature from a vehicle (feature is still in feature table)
DELETE FROM vehicle_feature WHERE vehicle_id = :vehicle_id_clicked 
AND feature_id = (SELECT feature_id FROM feature WHERE feature_name = :feature_name_input);

-- featureAdd.html
-- 2 steps, add to the feature table then add to the vehicle_feature table
INSERT INTO feature (feature_name, feature_description) VALUES (:feature_name, :feature_description);
INSERT INTO vehicle_feature (vehicle_id, feature_id, feature_value) 
VALUES (:vehicle_id_clicked, LAST_INSERT_ID(), :feature_value_input);
-- TODO: ADD FEATURE TO VEHICLE THAT ALREADY IS IN TABLE
