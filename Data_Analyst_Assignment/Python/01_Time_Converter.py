minutes=int(input())
hours = minutes // 60
mins = minutes % 60
if hours > 0 and mins > 0:
    print(f"{hours} hr{'s' if hours>1 else ''} {mins} minute{'s' if mins>1 else ''}")
elif hours > 0:
    print(f"{hours} hr{'s' if hours>1 else ''}")
else:
    print(f"{mins} minute{'s' if mins>1 else ''}")


