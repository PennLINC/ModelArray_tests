# original location: `ConFixel/confixel/notebooks/`

import os
import os.path as op
import sys

sys.path.append(os.path.join(os.path.dirname(
    os.path.dirname(os.path.abspath(__file__))), "confixel"))
from confixel.fixels import main   # noqa

main()
