import tkinter as tk
from tkinter import filedialog, messagebox

def numeros_a_binario(texto):
    try:
        numeros = [int(num) for num in texto.strip().split()]
        return ' '.join(format(num, '08b') for num in numeros)
    except ValueError:
        messagebox.showerror("Error", "Por favor, ingresa solo números válidos separados por espacios.")
        return ""

def convertir_a_binario():
    texto = entrada_texto.get().strip()  
    if texto:
        binario = numeros_a_binario(texto)
        resultado_var.set(binario)
    else:
        messagebox.showerror("Error", "Por favor ingresa algún texto o número válido")

def cargar_archivo():
    archivo = filedialog.askopenfilename(filetypes=[("Text files", "*.txt")])
    if archivo:
        with open(archivo, 'r') as f:
            contenido = f.read().strip()
            binario = numeros_a_binario(contenido)
            resultado_var.set(binario)
            guardar_archivo(binario)

def guardar_archivo(binario):
    archivo_guardar = filedialog.asksaveasfilename(defaultextension=".txt", filetypes=[("Text files", "*.txt")])
    if archivo_guardar:
        with open(archivo_guardar, 'w') as f:
            f.write(binario)
        messagebox.showinfo("Archivo guardado", f"El archivo binario se guardó como {archivo_guardar}")

ventana = tk.Tk()
ventana.title("Convertidor de Números a Binario")

frame = tk.Frame(ventana)
frame.pack(padx=10, pady=10)


etiqueta = tk.Label(frame, text="Introduce números separados por espacio:")
etiqueta.grid(row=0, column=0, padx=5, pady=5)

entrada_texto = tk.Entry(frame, width=50)
entrada_texto.grid(row=0, column=1, padx=5, pady=5)

boton_convertir = tk.Button(frame, text="Convertir a Binario", command=convertir_a_binario)
boton_convertir.grid(row=1, column=1, padx=5, pady=5)

boton_cargar_archivo = tk.Button(frame, text="Cargar archivo .txt", command=cargar_archivo)
boton_cargar_archivo.grid(row=2, column=1, padx=5, pady=5)

resultado_var = tk.StringVar()

etiqueta_resultado = tk.Label(frame, text="Resultado Binario:")
etiqueta_resultado.grid(row=3, column=0, padx=5, pady=5)

resultado_label = tk.Label(frame, textvariable=resultado_var, width=50, relief="sunken")
resultado_label.grid(row=3, column=1, padx=5, pady=5)

ventana.mainloop()
