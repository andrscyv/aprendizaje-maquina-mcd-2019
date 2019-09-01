Tarea 3: Lectura

Lee las páginas 167 - 170 de el Capítulo 9 de 
[este libro](http://www.stat.columbia.edu/~gelman/arm/) de Gelman y Hill. 
El capítulo 9 está aquí:

http://www.stat.columbia.edu/~gelman/arm/chap9.pdf

Esta lectura es de nivel medio/avanzado. Discutiremos entre todos las respuestas, y en lugar de seleccionar al azar voy a pedir voluntarios. 


1. (p 167) ¿Qué son las comparaciones predictivas según el texto? (nota: puedes ignorar
la frase "infinite superpopulation", en lugar de eso piensa que se trata una muestra
de una distribución, o de un proceso que genera los datos. Por ejemplo, tomar muestras de
una base de datos).

Las comparaciones predictivas es una forma de interpretar la regresión, en donde el modelo resultante predice la respuesta con base en la comparación de distintas unidades con valores de las variables independientes similares

2. (p 167) ¿Cuál es la diferencia de las comparaciones predictivas e inferencia causal? Según Gelman y Hill, ¿cuál requiere más supuestos?

La diferencia es que la inferencia causal busca predecir el nivel de respuesta en una misma unidad (sujeto de tratamiento). La inferencia cuasal requiere mas supuestos

3. En nuestro curso, qué tipo de análisis (predictivo o causal) nos interesa hacer principalmente?
Nos interesa analisis predictivo

4. (167-168) Explica en tus palabras cómo puedes obtener un efecto causal de cero, pero
una comparación predictiva positiva (coeficiente de regresión positivo)
Para dos niveles de tratamiento (control y tratamiento), bastaria que hubiera un sesgo de personas previamente enfermas en el grupo de control y de personas sanas en el de tratamiento. Así, habria correlación positiva con respecto al nivel de tratamiento.

5. (168-169) Explica en tus palabras cómo podrías obtener un efecto causal positivo,
pero una comparación predictiva igual a cero (coeficiente de regresión cero)
En una forma reciproca al anterior, si existe sesgo de personas enfermas en el grupo de tratamiento y personas sanas en el grupo de control. En promedio podría aparecer que, en el grupo de tratamiento, el nivel de respuesta es igual al del control

6. En los ejemplos anteriores, ¿cuál es la variable omitida que dificulta interpretar
causalmente la comparación predictiva?
El estado previo de salud es un "cofounding covariate"

7. Explica cuál es el problema fundamental de inferencia causal.
El problema fundamental consiste en querer predecir la diferencia entre el nivel de respuesta para un mismo individuo (unidad) cuando se le aplican distintos niveles de tratamiento bajo exactamente las mismas condiciones. Observar ambas respuestas es imposible.
