with open("equipment_maintenance_log.csv","r") as csv_file:
    for line in csv_file:
        print("("+line.strip().replace('"',"'").replace(",",", ")+"),")


# with open("memberships.csv","r") as csv_file:
#     for line in csv_file:
#         final_line="', '".join(line.strip().replace('"',"").split(","))
#         print("("+final_line+"'),")
