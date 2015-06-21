from libc.math cimport fmax, fmin, sqrt
from libc.stdlib cimport rand, RAND_MAX

DEF PI = 3.14159265358979323846

cdef inline float cy_random():
    return <float>rand()/<float>RAND_MAX


cdef inline float cy_radians(float degrees):
    return (degrees*PI)/180.0


cdef inline unsigned char char_lerp(unsigned char v0, unsigned char v1, 
    float t):
    return <unsigned char>((1-t)*v0 + t * v1)


cdef inline float random_variance(float base, float variance):
    return base + variance * (cy_random() * 2.0 - 1.0)


cdef void color_delta(unsigned char* color1, unsigned char* color2, 
    float* output, float dt):
    cdef int i 
    for i in range(4):
        output[i] = ((<float>color2[i] - <float>color1[i]) / dt)


cdef void color_variance(unsigned char* base, unsigned char* variance, 
    unsigned char* output):
    cdef int i
    for i in range(4):
        output[i] = <unsigned char>fmin(fmax(0., random_variance(<float>base[i], 
            <float>variance[i])), 255.)


cdef inline float calc_distance(float point_1_x, float point_1_y, 
    float point_2_x, float point_2_y):
    cdef float x_dist2 = pow(point_2_x - point_1_x, 2)
    cdef float y_dist2 = pow(point_2_y - point_1_y, 2)
    return sqrt(x_dist2 + y_dist2)