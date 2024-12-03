import cv2
import matplotlib.pyplot as plt

image_path = "image_data_scraping.png" 
image = cv2.imread(image_path)

coordinates = [
    (177, 413), (487, 413), (800, 413), (1113, 413), (1425, 413), (1736, 413),
    (103, 548), (290, 548), (482, 548), (672, 548), (863, 548), (1053, 548),
    (1243, 548), (1437, 548), (1627, 548), (1809, 548),
    (348, 608), (479, 608), (618, 608), (755, 608), (893, 608), (1027, 608),
    (1164, 608), (1300, 608), (1435, 608), (1568, 608),
    (486, 642), (582, 642), (692, 642), (801, 642), (906, 642), (1014, 642),
    (1120, 642), (1225, 642), (1334, 642), (1432, 642),
    (565, 663), (649, 663), (738, 663), (830, 663), (917, 663), (1001, 663),
    (1092, 663), (1178, 663), (1272, 663), (1351, 663),
    (630, 678), (704, 678), (772, 678), (850, 678), (923, 678), (994, 678),
    (1070, 678), (1142, 678), (1215, 678), (1286, 678),
    (679, 688), (739, 688), (798, 688), (867, 688), (930, 688), (990, 688),
    (1055, 688), (1116, 688), (1182, 688), (1244, 688),
    (701, 696), (759, 696), (817, 696), (874, 696), (932, 696), (988, 696),
    (1046, 696), (1102, 696), (1159, 696), (1215, 696),
    (732, 703), (779, 703), (828, 703), (885, 703), (934, 703), (985, 703),
    (1033, 703), (1090, 703), (1151, 703), (1196, 703)
]

image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

plt.figure(figsize=(12, 8))
plt.imshow(image_rgb)
plt.scatter(*zip(*coordinates), color="red", s=40, label="Selected Points") 

plt.title("Overlayed Points on Image")
plt.xlabel("X-coordinate")
plt.ylabel("Y-coordinate")
plt.legend(loc="upper left")
plt.gca().invert_yaxis()
plt.tight_layout()
plt.show()