import cv2
import matplotlib.pyplot as plt

image_path = "image_data_scraping.png"
image = cv2.imread(image_path)

points = []

def click_event(event):
    if event.xdata and event.ydata:
        x, y = int(event.xdata), int(event.ydata)
        points.append((x, y))
        print(f"Point selected: ({x}, {y})")
        # Plot the selected point
        plt.scatter(x, y, color='red')
        plt.draw()

def hover_event(event):
    if event.xdata and event.ydata:
        x, y = int(event.xdata), int(event.ydata)
        ax.set_title(f"Hovering at: ({x}, {y})")
        fig.canvas.draw_idle()

# Display the image
fig, ax = plt.subplots()
ax.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
fig.canvas.mpl_connect('button_press_event', click_event)
fig.canvas.mpl_connect('motion_notify_event', hover_event)
plt.show()