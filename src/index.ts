// @ts-ignore
const g = global as any;

const measureText = {
  measureText: g.measureText as (spec: {
    fontFamily: string;
    width: number;
    text: string;
    fontSize: number;
  }) => number,
};

export default measureText;
