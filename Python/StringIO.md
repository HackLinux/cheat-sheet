## StringIO

This module implements an in-memory file object. This object can be used as input or output to most functions that expect a standard file object.

When a StringIO object is created, it can be initialized to an existing string by passing the string to the constructor. If no string is given, the StringIO will start empty. In both cases, the initial file position starts at zero.
```python
In [33]: import StringIO

In [34]: out = StringIO.StringIO() # no string is given

In [35]: out.write('use write')

In [36]: out.getvalue() # Retrieve the entire contents of the “file” at any time before the StringIO object’s close() method is called
Out[36]: 'use write'

In [37]: out.read()
Out[37]: ''
# You need to reset the buffer position to the beginning. You can do this by doing out.seek(0).

# Every time you read or write to the buffer, the position is advanced by one. Say you start with an empty buffer.

# The buffer value is "", the buffer pos is 0. You do out.write("use write"). Obviously the buffer value is now "use write". The buffer position, however, is now 9. When you call read(), there is nothing past position 9 to read! So it returns an empty string.

In [38]: out_2 = StringIO.StringIO('not use write') # be initialized to an existing string by passing the string to the constructor

In [39]: out_2.getvalue()
Out[39]: 'not use write'

In [40]: out_2.read()
Out[40]: 'not use write'

In [41]: out
Out[41]: <StringIO.StringIO instance at 0xb5fe8a2c>

In [42]: out_2
Out[42]: <StringIO.StringIO instance at 0xb5fe87ec>

In [43]: out.close() # Free the memory buffer

In [44]: out
Out[44]: <StringIO.StringIO instance at 0xb5fe8a2c>

In [45]: out.getvalue()
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
ValueError: I/O operation on closed file

In [46]: out_2.close()

In [47]: out_2
Out[47]: <StringIO.StringIO instance at 0xb5fe87ec>

In [48]: out_2.read()
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
ValueError: I/O operation on closed file
```

> NOTE: cStringIO is removed in Python 3

- https://docs.python.org/2/library/stringio.html
- http://effbot.org/librarybook/stringio.htm
- [StringIO in Python 3](http://www.dotnetperls.com/stringio)
