class Vector:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
        
    def __str__(self):
        fields = [
            ("x", self.x),
            ("y", self.y),
            ("z", self.z)
        ]
        
        return "Vector { " + ", ".join(["%s=%s" % (k, v) for (k, v) in fields]) + " }"
        
vec = Vector(1, 2, 3)

print(vec)
print("{0}".format(42))
print(["%s=%s" % (42, 21) for (k, v) in [("a", 1), ("b", 2), ("c", 3)]])
